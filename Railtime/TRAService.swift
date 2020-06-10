import Foundation
import CryptoKit
import Combine


//TODO: Reduce duplication merge all webservice classes
final class TRAService: ObservableObject {
    
    private let appID = "cd4f9db10a48499e9e007850aac4e591"
    private let appKey = "tJGjzjdWSv8ipfZLNUxS5otl79k"
    let objectWillChange = ObservableObjectPublisher()
    
    
//    let dummyStation = Station(id: "0000", address: "NA", name: StationName(english: "DUMMY", chinese: "DUMMY"))
    
    @Published var stations: [Station] = [] {
        willSet {
            self.objectWillChange.send()
        }
    }
    // todo implement some sort of caching so it doesn't just reload every time
    @Published var trains: [Train] = [] {
        willSet {
            self.objectWillChange.send()
        }
    }
    
    @Published var timetable: Timetable? = nil {
        willSet {
            self.objectWillChange.send()
        }
    }
    
    init() {
        getStations()
    }
    
    
    func getServerTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ww zzz"
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter.string(from: Date())
    }
    
    func authenticateAndRequest(with endpoint: String) -> URLRequest? {
        guard let url = URL(string: endpoint) else {
            print ("Invalid URL for \(endpoint)")
            return nil
        }
        
        let xDate = getServerTime()
        let signDate = "x-date: \(xDate)"
        
        let key = SymmetricKey(data: Data(appKey.utf8))
        let hmac = HMAC<SHA256>.authenticationCode(for: Data(signDate.utf8), using: key)
        let base64HmacString = Data(hmac).base64EncodedString()
        
        let authorization = "hmac username=\"\(appID)\", algorithm=\"hmac-sha256\", headers=\"x-date\", signature=\"\(base64HmacString)\""
        
        var request = URLRequest(url: url)
        
        request.setValue(xDate, forHTTPHeaderField: "x-date")
        request.setValue(authorization, forHTTPHeaderField: "Authorization")
        request.setValue("gzip", forHTTPHeaderField: "Accept-Encoding")
        
        return request
        
    }
    
    func getSpecificTrainInfo(id: String) -> Void {
        print("called")
        // get today's date because we only care about today!
        // live in the now!
    

        
        guard let request = authenticateAndRequest(with: "https://ptx.transportdata.tw/MOTC/v2/Rail/TRA/DailyTimetable/Today/TrainNo/\(id)?$format=JSON") else {
            print("Invalid request.")
            return
        }
        
        print(request.url!)
        
        URLSession.shared.dataTask(with: request) {data, response, error in
            
            if let data = data {
                let content = String(data: data, encoding: .utf8)
                print(content!)
                
                if let decodedResponse = try? JSONDecoder().decode([Timetable].self, from: data) {
                    print("we trains")
                    
                    DispatchQueue.main.async {
//                        print(decodedResponse)
                        self.timetable = decodedResponse[0] //single elem
                    }
                    return
                }
                
                print("can't decode")
            }
            
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown Error")")
            
        }.resume()
        
    }
    
    func getTrainsFromStation(station: String) -> Void {
        print("called")
        // get today's date because we only care about today!
        // live in the now!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let now = dateFormatter.string(from: Date())
        
        
        // get station id
        let stationId = getStationFromName(city: station)!.id
        
        guard let request = authenticateAndRequest(with: "https://ptx.transportdata.tw/MOTC/v2/Rail/TRA/DailyTimetable/Station/\(stationId ?? String(0))/\(now)?$format=JSON") else {
            print("Invalid request.")
            return
        }
        
        print(request.url!)
        
        URLSession.shared.dataTask(with: request) {data, response, error in
            
            if let data = data {
                let content = String(data: data, encoding: .utf8)
                print(content!)
                
                if let decodedResponse = try? JSONDecoder().decode([Train].self, from: data) {
//                    print("we trains")
                    
                    DispatchQueue.main.async {
//                        print(decodedResponse)
                        self.trains = decodedResponse
                    }
                    return
                }
                
            }
            
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown Error")")
            
        }.resume()
        
    }
    
    func getStations() {
        guard let request = authenticateAndRequest(with: "https://ptx.transportdata.tw/MOTC/v2/Rail/TRA/Station?$top=30&$format=JSON") else {
            print("Invalid request.")
            return
        }
        
        
        
        URLSession.shared.dataTask(with: request) {data, response, error in
            
            if let data = data {
                print("we got A")
                let content = String(data: data, encoding: .utf8)
                print(content!)
                print("we got B")
                
                if let decodedResponse = try? JSONDecoder().decode([Station].self, from: data) {
                    print("we got here")
                    
                    DispatchQueue.main.async {
                        print("this works")
                        print(decodedResponse)
                        self.stations = decodedResponse
                    }
                    return
                } else {
                    print("oop...s")
                    print(error ?? "...")
                }
                
            }
            
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown Error")")
            
        }.resume()
        
        
        
    }
    
    func getStationFromName(city: String) -> Station? {
        return stations.first(where: {$0.name.english == city})
    }
    
    func getStationFromId(id: String) -> Station? {
        return stations.first(where: {$0.id == id})
    }
    
    func getNameFromId(id: String) -> String {
        return stations.first(where: {$0.id == id})?.name.english ?? "..."
    }
}

//
//  StationList.swift
//  Railtime
//
//  Created by Terran Kroft on 5/6/20.
//  Copyright © 2020 itemic. All rights reserved.
//

import Foundation

struct Timetable: Codable {
    enum CodingKeys: String, CodingKey {
        case trainInfo = "DailyTrainInfo"
        case trainDate = "TrainDate"
        case railStopTimes = "StopTimes"
    }
//    var id = UUID()
//    var VersionID: Int
    var trainInfo: RailDailyTrainInfo
    var railStopTimes: [RailStopTime]
    let trainDate: String
}

struct RailDailyTrainInfo: Codable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case id = "TrainNo"
        case startStation = "StartingStationName"
        case endStation = "EndingStationName"
        case direction = "Direction"
//        case note = "Note"

    }
    var id: String // use train id
    var startStation: StationName
    var endStation: StationName
    var direction: Int
//    var note: StationName // notes
}

struct RailStopTime: Codable {
    enum CodingKeys: String, CodingKey {
        case stopSequence = "StopSequence"
        case name = "StationName"
        case arrivalTime = "ArrivalTime"
        case departureTime = "DepartureTime"
    }

    var stopSequence: Int
    var name: StationName
    var arrivalTime: String
    var departureTime: String

}

//import Foundation
//struct Timetable: Codable {
//    let trainDate: String
//    let dailyTrainInfo: DailyTrainInfo
//    let stopTimes: [StopTime]
//    let updateTime: Date
//    let versionID: Int
//
//    enum CodingKeys: String, CodingKey {
//        case trainDate = "TrainDate"
//        case dailyTrainInfo = "DailyTrainInfo"
//        case stopTimes = "StopTimes"
//        case updateTime = "UpdateTime"
//        case versionID = "VersionID"
//    }
//}
//
//// MARK: - DailyTrainInfo
//struct DailyTrainInfo: Codable {
//    let trainNo: String
//    let direction: Int
//    let startingStationID: String
//    let startingStationName: StationName
//    let endingStationID: String
//    let endingStationName: StationName
//    let note: Note
//
//    enum CodingKeys: String, CodingKey {
//        case trainNo = "TrainNo"
//        case direction = "Direction"
//        case startingStationID = "StartingStationID"
//        case startingStationName = "StartingStationName"
//        case endingStationID = "EndingStationID"
//        case endingStationName = "EndingStationName"
//        case note = "Note"
//    }
//}
//
//// MARK: - StationName
//
//
//// MARK: - Note
//struct Note: Codable {
//}
//
//// MARK: - StopTime
//struct StopTime: Codable {
//    let stopSequence: Int
//    let stationID: String
//    let stationName: StationName
//    let arrivalTime, departureTime: String
//
//    enum CodingKeys: String, CodingKey {
//        case stopSequence = "StopSequence"
//        case stationID = "StationID"
//        case stationName = "StationName"
//        case arrivalTime = "ArrivalTime"
//        case departureTime = "DepartureTime"
//    }
//}

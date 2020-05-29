//
//  Train.swift
//  Railtime
//
//  Created by Terran Kroft on 5/8/20.
//  Copyright © 2020 itemic. All rights reserved.
//

import Foundation

struct Train: Codable, Identifiable, Hashable {
    
    enum CodingKeys: String, CodingKey {
        case id = "TrainNo"
        case start = "StartingStationID"
        case end = "EndingStationID"
        case direction = "Direction"
        case departureTime = "DepartureTime"
        case arrivalTime = "ArrivalTime"
        
    }
    var id: String // use train id
    var start: String
    var end: String
    var direction: Int
    var departureTime: String
    var arrivalTime: String
    
//    var formattedDeparture: String {
//        if let departure = departure {
//            let formatter = DateFormatter()
//            formatter.timeStyle = .short
//            return formatter.string(from: departure)
//        } else {
//            return "--"
//        }
//    }
    

    
    
    
}

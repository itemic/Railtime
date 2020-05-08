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
        case railStopTimes = "RailStopTime"
    }

    var trainInfo: RailDailyTrainInfo
    var railStopTimes: [RailStopTime]
}

struct RailDailyTrainInfo: Codable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case id = "TrainNo"
        case start = "StartingStationName"
        case end = "EndingStationName"
        case direction = "Direction"
        case note = "Note"
        
    }
    var id: String // use train id
    var start: StationName
    var end: StationName
    var direction: Int
    var note: StationName // notes
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

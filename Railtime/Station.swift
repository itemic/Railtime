//
//  Station.swift
//  Railtime
//
//  Created by Terran Kroft on 5/6/20.
//  Copyright © 2020 itemic. All rights reserved.
//

import Foundation

struct StationsInfo: Codable {
    var Stations: [Station]
}

struct Station: Codable, Identifiable {
    
    enum CodingKeys: String, CodingKey {
        case id = "StationID"
        case name = "StationName"
        case address = "StationAddress"
    }
    var id: String
    var address: String
    var name: StationName
}

struct StationName: Codable {
    var english: String
    var chinese: String
    
    enum CodingKeys: String, CodingKey {
        case english = "En"
        case chinese = "Zh_tw"
    }
}

enum Language {
    case english
    case chinese
}

//
//  TrainView.swift
//  Railtime
//
//  Created by Terran Kroft on 5/8/20.
//  Copyright © 2020 itemic. All rights reserved.
//

import SwiftUI

struct TrainView: View {
    @EnvironmentObject private var service: HSRService
    let trainId: String
    var body: some View {
        VStack {
            Text("Train \(trainId)")
            Text("Direction: \(service.timetable?.trainInfo.direction == 0 ? "Southbound" : "Northbound")")
            Text("\(service.timetable?.trainInfo.startStation.english ?? "?") → \(service.timetable?.trainInfo.endStation.english ?? "?")")
            Spacer()
            Text("This train stops at...")
            VStack {
                List {
                ForEach(service.timetable?.railStopTimes ?? [], id: \.stopSequence) { stop in
                    HStack {
                    Text("\(stop.name.english)")
                        Spacer()
                    Text("\(stop.departureTime)")
                        .bold()
                    }
                    
                }
                }
            }
            Spacer()
        }.onAppear(perform: load)
    }

    func load() {
        service.getSpecificTrainInfo(id: trainId)
    }

}

struct TrainView_Previews: PreviewProvider {
    static var previews: some View {
        TrainView(trainId: "0678").environmentObject(HSRService())
    }
}


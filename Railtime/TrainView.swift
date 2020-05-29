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
        ZStack {
            
                
            
//            self.service.timetable?.trainInfo.direction == 0 ? Color.green.edgesIgnoringSafeArea(.all) : Color.blue.edgesIgnoringSafeArea(.all)
            Color.orange.edgesIgnoringSafeArea(.all)
            VStack{
                VStack {
                //                       Spacer()
                                        Text("\(self.trainId)").font(.system(size: 64, weight: .bold, design: .rounded))
                                            .foregroundColor(.white)
                                        
                                        
                                        Text("\(self.service.timetable?.trainInfo.direction == 0 ? "SOUTHBOUND" : "NORTHBOUND")")
                                            .fontWeight(.semibold)
                                            .foregroundColor(self.service.timetable?.trainInfo.direction == 0 ? Color.green : Color.blue)
                                        .fixedSize(horizontal: true, vertical: true)
                                            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                                            .background(Color.white)
                                        .cornerRadius(10)
                                        
                                        
                                        Text("\(self.service.timetable?.trainInfo.startStation.english ?? "?") → \(self.service.timetable?.trainInfo.endStation.english ?? "?")")
                                            .foregroundColor(.white)
                //                        Spacer()
                                    
                                    }
                
                
                
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
        }
        .onAppear(perform: load)
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


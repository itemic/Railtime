//
//  ContentView.swift
//  Railtime
//
//  Created by Terran Kroft on 5/6/20.
//  Copyright © 2020 itemic. All rights reserved.
//

import SwiftUI

struct ContentView: View {
                        
    @EnvironmentObject private var service: HSRService
    @State private var selectedStation = "Zuoying"
    @State private var selectedIndex = ""
    @State private var selectedX = "Nangang"
    @State private var sortPickerChoice = 0
    
    
    var body: some View {
        NavigationView {
            VStack {
                stationScrolls
               
                List(service.trains.filter {
                    $0.direction == sortPickerChoice
                }) { train in
                    NavigationLink(destination: TrainView(trainId: train.id)) {
                    
                        HStack(alignment: .center) {
                            //                Spacer()
                            Image(systemName: "\(train.direction == 0 ? "s" : "n").circle.fill")
                                .foregroundColor(train.direction == 0 ? .green : .blue)
                            
                            VStack(alignment: .leading) {
                                Text("\(train.id)").font(.subheadline)
                                Text("\(self.service.getStationFromId(id: train.start)!.name.english) → \(self.service.getStationFromId(id: train.end)!.name.english)").font(.body)
                                
                                
                            }
                            Spacer()
                            Text("\(train.departureTime)")
                                .font(.system(.body, design: .monospaced))
                            
                            
                        
                    }
                    
                }
                }
                
                Spacer()
                Picker(selection: $sortPickerChoice, label: Text("Filter")) {
                                   Text("Southbound").tag(0)
                                   Text("Northbound").tag(1)
                                   
                               }.pickerStyle(SegmentedPickerStyle())
            }
            .navigationBarTitle("Railtime")
        }
    }
    
    var stationScrolls: some View {
        
            VStack {
//                Text("Selected: \(selectedX)")
                if !service.stations.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            ForEach(service.stations) {station in
                                
                                if self.selectedX == station.name.english {
                                    Button(action: {
                                        self.selectedX = station.name.english
                                        self.service.getTrainsFromStation(station: self.selectedX)
                                    }) {
                                        HStack {
                                            Image(systemName: "tram.fill")
                                            Text("\(station.name.english)")
                                                .fontWeight(.semibold)
                                            
                                        }
                                        
                                        
                                    }
                                    .buttonStyle(SelectedSimpleButtonStyle())
                                } else {
                                    Button(action: {
                                        self.selectedX = station.name.english
                                        self.service.getTrainsFromStation(station: self.selectedX)
                                    }) {
                                        HStack {
                                            Image(systemName: "tram.fill")
                                            Text("\(station.name.english)")
                                                .fontWeight(.semibold)
                                            
                                        }
                                        
                                        
                                    }
                                    .buttonStyle(DeselectedSimpleButtonStyle())
                                }
                                
                                
                                
                                
                            }.padding(2)
                        }
                    }
                } else {
                    Text("...")
                }
                
            }
            
            
            
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView().environmentObject(HSRService())
    }
}

struct SelectedSimpleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 90)
            .padding(10)
            .background(Color.orange)
            .cornerRadius(20)
            .foregroundColor(.white)
        
    }
}

struct DeselectedSimpleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 90)
            .padding(10)
            .background(Color.gray)
            .cornerRadius(20)
            .foregroundColor(.white)
        
    }
}

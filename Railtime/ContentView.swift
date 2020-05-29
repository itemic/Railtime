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
    
    
    @State private var selectedX = "Nangang"
    @State private var sortPickerChoice = 2
    @State private var showingActionSheet = false

    
    var time = {
        
    }
//    
//    init() {
//            self.service.getTrainsFromStation(station: "Nangang")
//    }
    
    var body: some View {
        NavigationView {
            VStack {
                
                stationScrolls
//                entryScrolls

               
                List(service.trains.filter {
                    sortPickerChoice == 2 ? true : $0.direction == sortPickerChoice
                }) { train in
                    NavigationLink(destination: TrainView(trainId: train.id)) {
                    
                        HStack(alignment: .center) {
                            //                Spacer()
                            Image(systemName: "\(train.direction == 0 ? "s" : "n").circle.fill")
                                .foregroundColor(train.direction == 0 ? .green : .blue)
                            
                            VStack(alignment: .leading) {
                                Text("\(train.id)").font(.system(.subheadline, design: .rounded))
                                HStack {
                                    Text("\(self.service.getStationFromId(id: train.start)!.name.english)")
                                    Text("→")
                                    Text("\(self.service.getStationFromId(id: train.end)!.name.english)")
                                        .fontWeight(self.isTerminus(train) ? .semibold: .none)
                                }
                                                                
                            }
                            Spacer()
                            Text("\(train.departureTime)")
                                .font(.system(.body, design: .monospaced))
                            
                            
                        
                        }.foregroundColor(self.isTerminus(train) ? .gray: .black)
                    
                    }.buttonStyle(PlainButtonStyle())
                }
                
                Spacer()

                Text("Last updated never.")
                Spacer()
                

                }
            .navigationBarTitle("Railtime")
            .navigationBarItems(trailing: Button(action: {
                self.showingActionSheet = true
            }) {
                Image(systemName: "line.horizontal.3.decrease.circle")
                    .onTapGesture(perform: {
                        self.showingActionSheet = true
                    })
                    .actionSheet(isPresented: $showingActionSheet) {
                        ActionSheet(title: Text("Filter trains"), buttons: [
                            .default(Text("All Trains")) {self.sortPickerChoice = 2},
                            .default(Text("Southbound Trains")) {self.sortPickerChoice = 0},
                            .default(Text("Northbound Trains")) {self.sortPickerChoice = 1},
                        
                            .cancel()
                        ])
                }
            })
            
        }
    }
    
    var entryScrolls: some View {
        VStack {
            ForEach(0..<service.trains.count) {index in
                Text(self.service.trains[index].id)
            }
        }
    }
    
    
    var stationScrolls: some View {
        
        VStack {
//                Text("Selected: \(selectedX)")
                if !service.stations.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing: 0){
                            Spacer()
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
                                Spacer()
                                
                                
                                
                                
                                }.padding(2).onAppear(perform: getTrainsFromStation)
                        }
                    }
                } else {
                    Text("...")
                }
                
            }
            
    }
    
    func getTrainsFromStation() {
        service.getTrainsFromStation(station: selectedX)
    }
    
    func isTerminus(_ train: Train) -> Bool {
        return service.getStationFromId(id: train.end)!.name.english == selectedX
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
            .fixedSize(horizontal: true, vertical: true)
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
            .fixedSize(horizontal: true, vertical: true)
            .padding(10)
            .background(Color.gray)
            .cornerRadius(20)
            .foregroundColor(.white)
        
    }
}

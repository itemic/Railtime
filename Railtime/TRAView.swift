//
//  HSRView.swift
//  Railtime
//
//  Created by Terran Kroft on 5/29/20.
//  Copyright © 2020 itemic. All rights reserved.
//

import SwiftUI

struct TRAView: View {
                        
    @EnvironmentObject private var service: TRAService
    
    
    @State private var selectedX = "Hsinchu"
    @State private var sortPickerChoice = 2
    @State private var showingActionSheet = false

    
    var time = {
        
    }
//
    init() {
             UINavigationBar.appearance().largeTitleTextAttributes = [
           .foregroundColor: UIColor.white]
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.navy.edgesIgnoringSafeArea(.all)
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
                                        Text("\(self.service.getNameFromId(id: train.start))")
                                        Text("→")
                                        Text("\(self.service.getNameFromId(id: train.end))")
                                            .fontWeight(self.isTerminus(train) ? .semibold: .none)
                                    }
                                                                    
                                }
                                Spacer()
                                Text("\(train.departureTime)")
                                    .font(.system(.body, design: .monospaced))
                                
                                
                            
                            }.foregroundColor(self.isTerminus(train) ? .secondary: .primary)
                                
                        
                        }.buttonStyle(PlainButtonStyle())
                    }

                    

                    }
                .navigationBarTitle("TRA")
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
                                    .buttonStyle(TRASelectedButton())
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
        return service.getNameFromId(id: train.end) == selectedX
//        return service.getStationFromId(id: train.end)!.name.english == selectedX
    }
}

struct TRAView_Previews: PreviewProvider {
    
    static var previews: some View {
        TRAView().environmentObject(HSRService())
    }
}


struct TRASelectedButton: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 90)
            .fixedSize(horizontal: true, vertical: true)
            .padding(10)
            .background(Color.white)
            .cornerRadius(20)
//            .foregroundColor(.navy)
        
    }
}


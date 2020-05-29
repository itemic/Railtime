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
    @State var isShowingHSRSheet = false
    @State var isShowingTRASheet = false
                        
    
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    self.isShowingHSRSheet.toggle()
                }) {
                CardView()
                }.sheet(isPresented: $isShowingHSRSheet) {
                    HSRView().environmentObject(HSRService())
                }
                
                Button(action: {
                    self.isShowingTRASheet.toggle()
                }) {
                Text("TRA")
                }.sheet(isPresented: $isShowingTRASheet) {
                    TRAView().environmentObject(HSRService())
                }
            }.navigationBarTitle("Railtime Today")
        }
    }
        
   
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View {
    var body: some View {
        VStack {
            Text("HSR")
        }.background(Color.orange)

        
        
    }
}

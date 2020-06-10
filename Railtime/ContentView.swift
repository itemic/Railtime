//
//  ContentView.swift
//  Railtime
//
//  Created by Terran Kroft on 5/6/20.
//  Copyright © 2020 itemic. All rights reserved.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @EnvironmentObject private var service: HSRService
    @State var isShowingHSRSheet = false
    @State var isShowingTRASheet = false
                        
    func generateHaptic() {
//        let generator = UINotificationFeedbackGenerator()
//        generator.notificationOccurred(.success)
    }
    

    
    
    
    
    var body: some View {
        NavigationView {
            VStack(spacing: 12) {
                Button(action: {
                    self.generateHaptic()
                    self.isShowingHSRSheet.toggle()
                }) {
                    CardView(content: "THSR", colors: [Color.hsrOrange, Color.orange])
                }.sheet(isPresented: $isShowingHSRSheet) {
                    HSRView().environmentObject(HSRService())
                }
                
//                Button(action: {
//                    self.generateHaptic()
//                    self.isShowingTRASheet.toggle()
//                }) {
//                    CardView(content: "TRA", colors: [Color.navy, Color.blue])
//                }.sheet(isPresented: $isShowingTRASheet) {
//                    TRAView().environmentObject(TRAService())
//                }
                
                CardView(content: "TRA", colors: [Color.gray, Color.gray])
                CardView(content: "Bus", colors: [Color.gray, Color.gray])

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
    let content: String
    let colors: [Color]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(content)
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundColor(.white)
        }
        .frame(width: 220)
    .padding()
        .background(LinearGradient.init(gradient: Gradient(colors: colors), startPoint: .leading, endPoint: .trailing))
    .cornerRadius(12)

        
        
    }
}

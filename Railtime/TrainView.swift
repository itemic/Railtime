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
            Text("Hey \(trainId)")
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


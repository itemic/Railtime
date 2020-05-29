//
//  Buttons.swift
//  Railtime
//
//  Created by Terran Kroft on 5/29/20.
//  Copyright © 2020 itemic. All rights reserved.
//

import SwiftUI


struct SelectedSimpleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 90)
            .fixedSize(horizontal: true, vertical: true)
            .padding(10)
            .background(Color.white)
            .cornerRadius(20)
            .foregroundColor(.orange)
        
    }
}

struct DeselectedSimpleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 90)
            .fixedSize(horizontal: true, vertical: true)
            .padding(10)
            .background(Color.secondary)
            .cornerRadius(20)
            .foregroundColor(.white)
        
    }
}

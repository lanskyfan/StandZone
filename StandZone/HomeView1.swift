//
//  HomeView1.swift
//  StandZone
//
//  Created by yifanlan on 3/18/22.
//

import SwiftUI

struct HomeView1: View {
    @ObservedObject var myController: StandZoneController

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct HomeView1_Previews: PreviewProvider {
    static var previews: some View {
        HomeView1(myController: StandZoneController())
    }
}

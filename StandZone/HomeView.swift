//
//  HomeView.swift
//  StandZone
//
//  Created by yifanlan on 3/18/22.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var myController: StandZoneController
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(myController: StandZoneController())
    }
}

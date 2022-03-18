//
//  mainView.swift
//  StandZone
//
//  Created by yifanlan on 3/17/22.
//

import SwiftUI

struct SwitchView: View {
    @ObservedObject var myController: StandZoneController

    var body: some View {
        switch myController.getScreen() {
        case Screen.initialView:
            InitialView(myController: myController)
        case Screen.logInView:
            LoginView(myController: myController)
        case Screen.registerView:
            RegisterView(myController: myController)
        case Screen.registerView1:
            RegisterView1(myController: myController)
        case Screen.registerView2:
            RegisterView2(myController: myController)
        case Screen.registerView3:
            RegisterView3(myController: myController)
        case Screen.registerView4:
            RegisterView4(myController: myController)
        case Screen.homeView:
            HomeView(myController: myController)
        
        }
    }
}

struct SwitchView_Previews: PreviewProvider {
    static var previews: some View {
        SwitchView(myController: StandZoneController())
    }
}

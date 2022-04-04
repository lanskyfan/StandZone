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
            RegisterView1(myController: myController, healthController: myController.healthController)
        case Screen.registerView2:
            RegisterView2(myController: myController)
        case Screen.registerView3:
            RegisterView3(myController: myController)
        case Screen.registerView4:
            RegisterView4(myController: myController)
        case Screen.homeView:
            HomeView(myController: myController, healthController: myController.healthController)
        case Screen.homeView1:
            HomeView1(myController: myController, healthController: HealthViewController())
        case Screen.homeView2:
            HomeView2(newController: myController)
        case Screen.mainView:
            MainView(newController: myController, newHealthController: myController.healthController)
                .transition(AnyTransition.opacity.animation(.linear(duration: 1)))
        }
    }
}

struct SwitchView_Previews: PreviewProvider {
    static var previews: some View {
        SwitchView(myController: StandZoneController())
    }
}

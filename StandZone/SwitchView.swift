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
        if myController.getScreen() == 0 {
            InitialView(myController: myController)
        } else if myController.getScreen() == 1{
            RegisterView(myController: myController)
        } else if myController.getScreen() == 2 {
            LoginView(myController: myController)
        } else if myController.getScreen() == 3 {
            RegisterView1(myController: myController)
        } else if myController.getScreen() == 4 {
            RegisterView2(myController: myController)
        } else if myController.getScreen() == 5 {
            RegisterView3(myController: myController)
        } else if myController.getScreen() == 6 {
            RegisterView4(myController: myController)
        }
        else {
            // Main page
        }
    }
}

struct SwitchView_Previews: PreviewProvider {
    static var previews: some View {
        SwitchView(myController: StandZoneController())
    }
}

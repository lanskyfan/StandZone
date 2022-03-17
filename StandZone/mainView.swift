//
//  mainView.swift
//  StandZone
//
//  Created by yifanlan on 3/17/22.
//

import SwiftUI

struct mainView: View {
    @State var screen = 0

    var body: some View {
        return Group {
            if screen == 0 {
                InitialView(screen: $screen)
            } else if screen == 1{
                RegisterView()
            } else {
                LoginView()
            }
        }
    }
}

struct mainView_Previews: PreviewProvider {
    static var previews: some View {
        mainView()
    }
}

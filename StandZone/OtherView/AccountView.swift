//
//  AccountView.swift
//  StandZone
//
//  Created by yifanlan on 4/17/22.
//

import SwiftUI

struct AccountView: View {
    @ObservedObject var myController: StandZoneController
    var body: some View {
        NavigationView {
            ZStack {
                Image("background1")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("If you want to compete with more friends, please create an account or log in with existing account")
                    VStack (spacing: 20){

                        NavigationLink(destination: RegisterView(myController: myController)) {
                            ButtonView(myController: myController, nextScreen: Screen.registerView, content: "CREATE AN ACCOUNT")
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        NavigationLink(destination: LoginView(myController: myController)) {
                            ButtonView(myController: myController, nextScreen: Screen.logInView, content: "LOG IN WITH EXISTING ACCOUNT")
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                    }.padding()

                }.padding()
            }
        }

        
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(myController: StandZoneController())
    }
}

//
//  LoginView.swift
//  StandZone
//
//  Created by yifanlan on 3/17/22.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var myController: StandZoneController
    @State private var email: String = ""
    @State private var password: String = ""
    var body: some View {
        ZStack {
            Image("background1")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack (spacing: 20){
                VStack {
                    HStack {
                        Image(systemName: "person.fill").font(.system(size: 30))
                        Text("Email Address").bold()
                    }
                    TextField(text: $email, prompt: Text("Required")) {
                        Text("Username")
                    }.padding().disableAutocorrection(true)
                    HStack {
                        Image(systemName: "key.fill").font(.system(size: 30))
                        Text("Password").bold()
                    }
                    SecureField(text: $password, prompt: Text("Required")) {
                        Text("Password")
                    }.padding()
                }.textFieldStyle(.roundedBorder)

                ContinueButton(content: "Continue")
                    .onTapGesture {
                        myController.updateScreen(newScreen: Screen.mainView)
                    }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(myController: StandZoneController())
    }
}

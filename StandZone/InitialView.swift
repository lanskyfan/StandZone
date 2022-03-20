//
//  InitialView.swift
//  StandZone
//
//  Created by yifanlan on 3/16/22.
//

import SwiftUI

struct InitialView: View {
    @ObservedObject var myController: StandZoneController
    var body: some View {
        NavigationView {
            ZStack {
                Image("background1")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Welcome to Stand Zone").bold().font(.title)
                    Text("keep standing and live a healthy life")
                    VStack (spacing: 20){
                        // Need to update
                        NavigationLink(destination: LoginView(myController: myController)) {
                            ButtonView(myController: myController, nextScreen: Screen.registerView, content: "LOG IN WITH FACEBOOK")
                        }
                        .buttonStyle(PlainButtonStyle())

                        NavigationLink(destination: LoginView(myController: myController)) {
                            ButtonView(myController: myController, nextScreen: Screen.registerView, content: "LOG IN WITH GOOGLE")
                        }
                        .buttonStyle(PlainButtonStyle())

                        NavigationLink(destination: RegisterView(myController: myController)) {
                            ButtonView(myController: myController, nextScreen: Screen.registerView, content: "CREATE AN ACCOUNT")
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        NavigationLink(destination: LoginView(myController: myController)) {
                            ButtonView(myController: myController, nextScreen: Screen.logInView, content: "LOG IN WITH EXISTING ACCOUNT")
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        NavigationLink(destination: RegisterView1(myController: myController)) {
                            ButtonView(myController: myController, nextScreen: Screen.registerView1, content: "CONTINUE WITHOUT ACCOUNT", myColor: .gray)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }.padding()

                }.padding()
            }
        }

        
    }
}



struct ButtonView: View {
    @ObservedObject var myController : StandZoneController
    var nextScreen: Screen
    var content: String
    var myColor: Color = .green1
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 10)
            shape.fill().foregroundColor(myColor).frame(width: 300, height: 40)
            Text(content)
        }
//        .onTapGesture {
//            myController.updateScreen(newScreen: nextScreen)
//        }
    }
}


extension Color {
    static let oldPrimaryColor = Color(UIColor.systemIndigo)
    static let green1 = Color("MyGreen1")
    static let green2 = Color("MyGreen2")
    static let blue1 = Color("MyBlue1")
}

struct ContentView_Previews: PreviewProvider {
    @State var screen = 1
    static var previews: some View {
        InitialView(myController: StandZoneController())
    }
}

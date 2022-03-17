//
//  InitialView.swift
//  StandZone
//
//  Created by yifanlan on 3/16/22.
//

import SwiftUI

struct InitialView: View {
    @Binding var screen: Int
    var body: some View {
        ZStack {
            Image("background1")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Welcome to Stand Zone").bold().font(.title)
                Text("keep standing and live a healthy life")
                VStack (spacing: 20){
                    ButtonView(screen: $screen, nextScreen: -1, content: "LOG IN WITH FACEBOOK")
                    ButtonView(screen: $screen, nextScreen: -1, content: "LOG IN WITH GOOGLE")
                    ButtonView(screen: $screen, nextScreen: 1, content: "CREATE AN ACCOUNT")
                    ButtonView(screen: $screen, nextScreen: 2, content: "LOG IN WITH EXISTING ACCOUNT")
                    ButtonView(screen: $screen, nextScreen: 3, content: "CONTINUE WITHOUT ACCOUNT", myColor: .gray)
                }.padding()

            }.padding()
        }
        
    }
}



struct ButtonView: View {
    @Binding var screen: Int
    var nextScreen: Int
    var content: String
    var myColor: Color = .green1
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 10)
            shape.fill().foregroundColor(myColor).frame(width: 300, height: 40)
            Text(content)
        }
        .onTapGesture {
            screen = nextScreen
        }
    }
}


extension Color {
    static let oldPrimaryColor = Color(UIColor.systemIndigo)
    static let green1 = Color("MyGreen1")
    static let green2 = Color("MyGreen2")
    static let blue1 = Color("MyBlue1")
}

//struct ContentView_Previews: PreviewProvider {
//    @State var screen = 1
//    static var previews: some View {
//        InitialView(screen: $screen)
//    }
//}

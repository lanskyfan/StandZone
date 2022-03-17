//
//  RegisterView.swift
//  StandZone
//
//  Created by yifanlan on 3/17/22.
//

import SwiftUI

struct RegisterView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        ZStack {
            Image("background1")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack (spacing: 20){

                ZStack {
                    Circle().fill(.white).frame(width: 120, height: 120.0)
                    Circle().strokeBorder(lineWidth: 3).frame(width: 120, height: 120.0)
                    Image(systemName: "camera.shutter.button.fill").font(.system(size: 40))
                }
                Text("Optional")
                Text("")
                VStack {
                    HStack {
                        Image(systemName: "person.fill").font(.system(size: 30))
                        Text("Email Address").bold()
                    }
                    TextField(text: $email, prompt: Text("Required")) {
                        Text("Username")
                    }.padding()
                    HStack {
                        Image(systemName: "key.fill").font(.system(size: 30))
                        Text("Password").bold()
                    }
                    SecureField(text: $password, prompt: Text("Required")) {
                        Text("Password")
                    }.padding()
                }.textFieldStyle(.roundedBorder)

                ContinueButton(content: "Continue")
            }
        }

    }
}

 
struct ContinueButton: View {
    var content: String
    var myColor: Color = .green1
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 10)
            shape.fill().foregroundColor(myColor).frame(width: 200, height: 60)
            Text(content).foregroundColor(.white).bold()
        }
    }
}



struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

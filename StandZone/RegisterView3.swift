//
//  RegisterView3.swift
//  StandZone
//
//  Created by yifanlan on 3/17/22.
//

import SwiftUI

struct RegisterView3: View {
    @ObservedObject var myController: StandZoneController
    var body: some View {
        ZStack {
            Image("background1")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image(systemName: "figure.wave").font(.system(size: 80))
                Text("Get Standing reminder").bold().font(.title)
                Text("We will always pay attention to your standing and remind you to stand at the right time")
                VStack (spacing: 20){
                    ButtonView2(content: "Agree")
                        .onTapGesture {
                            myController.updateScreen(newScreen: 6)
                        }
                    ButtonView2(content: "Disagree", myColor: .white)
                }.padding()

            }.padding()
        }
        
    }
}


struct ButtonView2: View {
    var content: String
    var myColor: Color = .green1
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 10)
            shape.fill().foregroundColor(myColor).frame(width: 300, height: 40)
            Text(content)
        }
    }
}


struct RegisterView3_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView3(myController: StandZoneController())
    }
}

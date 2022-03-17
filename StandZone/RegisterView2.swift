//
//  RegisterView2.swift
//  StandZone
//
//  Created by yifanlan on 3/17/22.
//

import SwiftUI

struct RegisterView2: View {
    @State private var nickName: String = ""
    @State private var password: String = ""
    var body: some View {
        ZStack (alignment: .top) {
            Image("background1")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack (spacing: 20){
//                MyShape()
                ProgressCircle()
                Spacer()
                    .frame(height: 40)
                Text("Notification Schedule").bold().font(.title)
                Spacer()
                    .frame(height: 40)
                TimeView()
                Spacer()
                    .frame(height: 40)
                ContinueButton(content: "Continue")
                Spacer()
                    .frame(height: 60)
            }
            .padding()
            
            
        }
    }
}

struct RegisterView2_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView2()
    }
}

struct TimeView: View {
    
    @State private var currentDate = Date()
    
    var body: some View {
        VStack {
            HStack {
                Text("Wake up time").bold()
                Spacer().frame(width: 40)
                Text("Sleeping time").bold()
            }
            HStack {
                VStack {
                    DatePicker("", selection: $currentDate, displayedComponents: [.hourAndMinute])
                    .labelsHidden()
                }.padding()
                Text("To")
                VStack {
                    DatePicker("", selection: $currentDate, displayedComponents: [.hourAndMinute])
                    .labelsHidden()
                }.padding()
            }
        }


    }
}

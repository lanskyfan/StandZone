//
//  RegisterView4.swift
//  StandZone
//
//  Created by yifanlan on 3/17/22.
//

import SwiftUI

struct RegisterView4: View {
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
                Text("Set Daily Goal").bold().font(.title)
                Spacer()
                    .frame(height: 40)
                frequencyStepperView()
                timeStepperView()
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

struct RegisterView4_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView4()
    }
}

struct frequencyStepperView: View {
    @State var stepperValue: Int = 0

    var body: some View {
        HStack {
            Text("Stand Frequency")
            VStack {
                Stepper("\(stepperValue)", value: $stepperValue)
            }.padding()
        }

    }
}

struct timeStepperView: View {
    @State var stepperValue: Int = 0

    var body: some View {
        HStack {
            Text("Standing time (min)")
            VStack {
                Stepper("\(stepperValue)", value: $stepperValue)
            }.padding()
        }
    }
}

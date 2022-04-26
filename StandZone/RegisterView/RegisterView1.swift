//
//  RegisterView1.swift
//  StandZone
//
//  Created by yifanlan on 3/17/22.
//

import SwiftUI
import HealthKit

struct RegisterView1: View {
    @ObservedObject var myController: StandZoneController
    @ObservedObject var healthController: HealthViewController
    @State private var nickName: String = ""
    @State private var gender: Gender = Gender.Male
    var body: some View {
        ZStack (alignment: .top){
            Image("background1")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack (spacing: 20){
//                MyShape()
                ProgressCircle()
                Spacer()
                    .frame(height: 40)
                Text("Simple settings are required for initial use").bold().font(.title)
                    .alert("We'll get your standing time from Apple Health", isPresented: $healthController.notRequestedHealthData) {
                        Button("Allow") {
                            print("Requesting HealthKit authorization...")
                            myController.healthController.requestHealthAuthorization()
                        }
                        
                        Button("No", role: .cancel) {
                            print("alert")
                        }
                    }

                VStack {
                    HStack {
                        Image(systemName: "person.fill").font(.system(size: 30))
                        Text("Nickname").bold()
                    }
                    TextField(text: $nickName, prompt: Text("Required")) {
                        Text("Username")
                    }.padding().disableAutocorrection(true)


                }.textFieldStyle(.roundedBorder)
//                GenderView(gender: $gender)
                Spacer()
                    .frame(height: 40)
                NavigationLink(destination: RegisterView2(myController: myController)) {
                    ContinueButton(content: "Continue")
                }
                .simultaneousGesture(TapGesture().onEnded{
                    myController.updateName(newName: nickName)
                    print("update gender = " + "\(gender)")
                    myController.updateGender(newGender: gender)
                })
                .buttonStyle(PlainButtonStyle())
                Spacer()
                    .frame(height: 60)
            }
            .padding()
            
        }
        .onAppear{
            healthController.getHealthAuthorizationRequestStatus()
        }
    }

}

// draw a curve
struct MyShape : Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()

        p.addArc(center: CGPoint(x: 300, y:100), radius: 30, startAngle: .degrees(0), endAngle: .degrees(90), clockwise: true)

        return p.strokedPath(.init(lineWidth: 3, dash: [5, 3], dashPhase: 10))
    }
}

struct ProgressCircle : View {
    var body: some View {
        HStack {
            Spacer()
            Circle()
               .trim(from: 0.25, to: 1.0)
               .rotation(.degrees(-90))
               .stroke(Color.black ,style: StrokeStyle(lineWidth: 3, lineCap: .butt, dash: [5,3], dashPhase: 10))
               .frame(width: 52, height: 52)
        }
        .padding()
    }

}

struct GenderView: View {
    @Binding var gender: Gender
    var body: some View {
        HStack {
            Image(systemName: "person.2.fill").font(.system(size: 30))
            Text("Gender").bold()
        }
        List {
            Picker("Gender", selection: $gender) {
                Text("Male").tag(Gender.Male)
                Text("Female").tag(Gender.Female)
            }
            .pickerStyle(.menu)
        }
    }
}

struct RegisterView1_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView1(myController: StandZoneController(), healthController: HealthViewController())
    }
}

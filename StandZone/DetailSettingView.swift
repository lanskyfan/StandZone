//
//  DetailSettingView.swift
//  StandZone
//
//  Created by yifanlan on 3/20/22.
//

import SwiftUI

struct DetailSettingView: View {
    @ObservedObject var myController: StandZoneController
    var body: some View {
        ZStack {
            Image("background1")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack {
                SettingTopView()
                BasicInfoView(myController: myController)
                DailyGoalNoLinkView(myController: myController)
            }
        }
    }
}

struct BasicInfoView: View {
    @ObservedObject var myController: StandZoneController
    @State private var name = "Roxanne"
    @State private var gender = "Female"
    var body: some View {

            ZStack {
                    let shape = RoundedRectangle(cornerRadius: 10)
                    shape.fill().foregroundColor(.green2).frame(height: 160)
                VStack {
                    HStack {
                            Text("Basic Information").foregroundColor(.black)
                            Spacer()
                    }
                    
                    ZStack {
                        let shape = RoundedRectangle(cornerRadius: 10)
                        shape.fill().foregroundColor(.white).frame(height: 40)
                        HStack {
                            Text("Nickname")
                            Spacer()
                            TextField(text: $name, prompt: Text("Required")) {
                                Text("Username")
                            }.disableAutocorrection(true)
                                .multilineTextAlignment(.trailing)
                                .frame(width: 100)
                            
                        }
                        .padding()
                    }

                    ZStack {
                        let shape = RoundedRectangle(cornerRadius: 10)
                        shape.fill().foregroundColor(.white).frame(height: 40)
                        HStack {
                            Text("Gender")
                            Spacer()
                            TextField(text: $gender, prompt: Text("Required")) {
                                Text("Gender")
                            }.disableAutocorrection(true)
                                .multilineTextAlignment(.trailing)
                                .frame(width: 100)                        }
                        .padding()
                    }

                    
                }
                .padding()

            }
            .padding()
        }
}

struct DailyGoalNoLinkView: View {
    @ObservedObject var myController: StandZoneController
    @State private var frequency = "12"
    @State private var time = "120"
    var body: some View {

            ZStack {
                    let shape = RoundedRectangle(cornerRadius: 10)
                    shape.fill().foregroundColor(.green2).frame(height: 160)
                VStack {
                    HStack {
                            Text("Daily Goal").foregroundColor(.black)
                            Spacer()
                    }
                    
                    ZStack {
                        let shape = RoundedRectangle(cornerRadius: 10)
                        shape.fill().foregroundColor(.white).frame(height: 40)
                        HStack {
                            Text("Standing frequency")
                            Spacer()
                            TextField(text: $frequency, prompt: Text("Required")) {
                                Text("Username")
                            }.disableAutocorrection(true)
                                .multilineTextAlignment(.trailing)
                                .frame(width: 100)
                                .keyboardType(.numberPad)
                            
                        }
                        .padding()
                    }

                    ZStack {
                        let shape = RoundedRectangle(cornerRadius: 10)
                        shape.fill().foregroundColor(.white).frame(height: 40)
                        HStack {
                            Text("Standing time")
                            Spacer()
                            TextField(text: $time, prompt: Text("Required")) {
                                Text("Username")
                            }.disableAutocorrection(true)
                                .multilineTextAlignment(.trailing)
                                .frame(width: 100)
                                .keyboardType(.numberPad)
                            
                        }
                        .padding()
                    }
                    
                }
                .padding()

            }
            .padding()
        }
}

struct DetailSettingView_Previews: PreviewProvider {
    static var previews: some View {
        DetailSettingView(myController: StandZoneController())
    }
}

//
//  HomeView.swift
//  StandZone
//
//  Created by yifanlan on 3/18/22.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var myController: StandZoneController
    @ObservedObject var healthController: HealthViewController
    var body: some View {
        VStack {
            HStack {        
                Text("Hello " + myController.getUserInfo().getName()).bold()
                Spacer()
            }
            .padding()
            
            ZStack {
                Image("world2")
                    .resizable()
                    .frame(width: 146.0, height: 146.0)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                FrequencyCircle(myController: myController, healthController: healthController)
                TimeCircle(myController: myController, healthController: healthController)
            }
            DigitView(myController: myController, healthController: healthController)
            Spacer()
            DataView(myController: myController, healthController: healthController)

        }

    }
}



struct FrequencyCircle : View {
    @ObservedObject var myController: StandZoneController
    @ObservedObject var healthController: HealthViewController
    var body: some View {
        HStack {
            Circle()
                .trim(from: CGFloat(1 - CGFloat(healthController.todayStandHourCount) / CGFloat(myController.getUserInfo().getFrequencyGoal())), to: 1.0)
               .rotation(.degrees(-90))
               .stroke(Color.green1 ,style: StrokeStyle(lineWidth: 8, lineCap: .butt))
               .frame(width: 150, height: 150)
        }
        .padding()
    }

}

struct TimeCircle : View {
    @ObservedObject var myController: StandZoneController
    @ObservedObject var healthController: HealthViewController
    var body: some View {
        HStack {
            Circle()
                .trim(from:CGFloat(1 - CGFloat(healthController.todayStandTimeTotal) / CGFloat(myController.getUserInfo().getTimeGoal() * 5)), to: 1.0)
               .rotation(.degrees(-90))
               .stroke(Color.blue1 ,style: StrokeStyle(lineWidth: 8, lineCap: .butt))
               .frame(width: 134, height: 134)
        }
        .padding()
    }

}



struct DigitView: View {
    @ObservedObject var myController: StandZoneController
    @ObservedObject var healthController: HealthViewController
    var body: some View {
        HStack {
            ZStack {
                let shape = RoundedRectangle(cornerRadius: 10)
                shape.fill().foregroundColor(.green1).frame(height: 60)
                VStack {
                    Text("Stand Frequency").bold()
                    Text(String(healthController.todayStandHourCount) + "/" + String(myController.getUserInfo().getFrequencyGoal())).bold()
                }
            }
            ZStack {
                let shape = RoundedRectangle(cornerRadius: 10)
                shape.fill().foregroundColor(.blue1)
                    .frame(height: 60)
                VStack {
                    Text("Stand Time").bold()
                    Text(String(healthController.todayStandTimeTotal) + "/" + String(myController.getUserInfo().getTimeGoal() * 5)).bold()
                }
            }
        }.padding()
    }
}


struct DataView: View {
    @ObservedObject var myController: StandZoneController
    @ObservedObject var healthController: HealthViewController
    var body: some View {
        ZStack() {
            Image("background3")
                .resizable()
                .scaledToFill()
                .frame(height: 250)
            VStack {
                Text("Today's Record")
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                ScrollView {
                    VStack (alignment: .leading){
                        ForEach(healthController.todayStandTime) {data in
                            HStack {
                                Text(data.getDate())
                                    .foregroundColor(.white)
                                    .font(.system(size: 20))
                                Spacer()
                                Text(String(format:" %.1f minutes", data.value))
                                    .foregroundColor(.white)
                                    .font(.system(size: 20))
                            }

                        }
                    }
                    .padding(.horizontal, 40.0)
                }
            }
        }
        .frame(height: 250)


    }
    
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(myController: StandZoneController(), healthController: HealthViewController())
    }
}

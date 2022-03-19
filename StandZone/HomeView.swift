//
//  HomeView.swift
//  StandZone
//
//  Created by yifanlan on 3/18/22.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var myController: StandZoneController
    var body: some View {
        VStack {
            HStack {
                Text("Hello Roxanne").bold()
                Spacer()
            }
            .padding()
            
            ZStack {
                Image("world2")
                    .resizable()
                    .frame(width: 146.0, height: 146.0)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                FrequencyCircle()
                TimeCircle()
            }
            DigitView()
            Spacer()
                MiddleView(myController: myController)
//                BottomView()

        }

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(myController: StandZoneController())
    }
}

struct FrequencyCircle : View {
    var body: some View {
        HStack {
            Circle()
               .trim(from: 0.25, to: 1.0)
               .rotation(.degrees(-90))
               .stroke(Color.green1 ,style: StrokeStyle(lineWidth: 8, lineCap: .butt))
               .frame(width: 150, height: 150)
        }
        .padding()
    }

}

struct TimeCircle : View {
    var body: some View {
        HStack {
            Circle()
               .trim(from: 0.4, to: 1.0)
               .rotation(.degrees(-90))
               .stroke(Color.blue1 ,style: StrokeStyle(lineWidth: 8, lineCap: .butt))
               .frame(width: 134, height: 134)
        }
        .padding()
    }

}



struct DigitView: View {
    var body: some View {
        HStack {
            ZStack {
                let shape = RoundedRectangle(cornerRadius: 10)
                shape.fill().foregroundColor(.green1).frame(height: 60)
                VStack {
                    Text("Stand Frequency").bold()
                    Text("6/12").bold()
                }
            }
            ZStack {
                let shape = RoundedRectangle(cornerRadius: 10)
                shape.fill().foregroundColor(.blue1)
                    .frame(height: 60)
                VStack {
                    Text("Stand Time").bold()
                    Text("90/120 mins")
                }
            }
        }.padding()
    }
}


struct MiddleView: View {
    @ObservedObject var myController: StandZoneController
    var body: some View {
        VStack(spacing: 0.0) {
            Image("background3")
                .resizable()
                .scaledToFill()
                .frame(height: 250)
        }


    }
    
}

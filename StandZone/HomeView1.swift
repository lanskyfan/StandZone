//
//  HomeView1.swift
//  StandZone
//
//  Created by yifanlan on 3/18/22.
//

import SwiftUI
import SwiftUICharts

struct HomeView1: View {
    @ObservedObject var myController: StandZoneController

    var body: some View {
        VStack {
            HStack {
                Text("Last Week").bold().font(.title).padding([.leading, .bottom])
                Spacer()
            }
            HStack {
                Text("Feb 28, 2022 to today").padding([.leading])
                Spacer()
            }
            PeriodSwitcher()
            FrequencyGraph()
                .padding()
            TimeGraph()
                .padding()
        }
        .navigationBarTitle("4")
        .navigationBarHidden(true)
 
    }
}

struct PeriodSwitcher: View {
    @State private var didTap:Bool = false

      var body: some View {
          HStack {
              Button(action: {
                  self.didTap = true
              }) {

              Text("Day")
              }
              
              Button(action: {
                  self.didTap = true
              }) {

              Text("Week")
              }
              
              Button(action: {
                  self.didTap = true
              }) {

              Text("Month")
              }
              
              Button(action: {
                  self.didTap = true
              }) {

              Text("Year")
              }
//                  .font(.system(size: 24))
//              }
//      //        .frame(width: 300, height: 75, alignment: .center)
//              .padding(.all, 20)
//              .background(didTap ? Color.blue : Color.yellow)
          }

      }
}


struct FrequencyGraph: View {
    var body: some View {
        let highIntensity = Legend(color: .orange, label: "High Intensity", order: 5)
        let buildFitness = Legend(color: .yellow, label: "Build Fitness", order: 4)
        let fatBurning = Legend(color: .green, label: "Fat Burning", order: 3)
        let warmUp = Legend(color: .blue, label: "Warm Up", order: 2)
        let low = Legend(color: .gray, label: "Low", order: 1)

        let limit = DataPoint(value: 130, label: "5", legend: fatBurning)

        let points: [DataPoint] = [
            .init(value: 70, label: "1", legend: low),
            .init(value: 90, label: "2", legend: warmUp),
            .init(value: 91, label: "3", legend: warmUp),
            .init(value: 130, label: "5", legend: fatBurning),
            .init(value: 135, label: "7", legend: fatBurning),
            .init(value: 136, label: "9", legend: fatBurning),
            .init(value: 138, label: "10", legend: fatBurning),
            .init(value: 150, label: "11", legend: buildFitness),
            .init(value: 151, label: "12", legend: buildFitness),
            .init(value: 150, label: "13", legend: buildFitness),
            .init(value: 136, label: "14", legend: fatBurning),
            .init(value: 130, label: "17", legend: fatBurning),
            .init(value: 150, label: "18", legend: buildFitness),
            .init(value: 150, label: "20", legend: buildFitness),
            .init(value: 160, label: "21", legend: highIntensity),
            .init(value: 158, label: "24", legend: highIntensity),
        ]

        
        
        BarChartView(dataPoints: points, limit: limit)
    }
}

struct TimeGraph: View {
    var body: some View {
        let highIntensity = Legend(color: .orange, label: "High Intensity", order: 5)
        let buildFitness = Legend(color: .yellow, label: "Build Fitness", order: 4)
        let fatBurning = Legend(color: .green, label: "Fat Burning", order: 3)
        let warmUp = Legend(color: .blue, label: "Warm Up", order: 2)
        let low = Legend(color: .gray, label: "Low", order: 1)

        let limit = DataPoint(value: 130, label: "5", legend: fatBurning)

        let points: [DataPoint] = [
            .init(value: 70, label: "1", legend: low),
            .init(value: 90, label: "2", legend: warmUp),
            .init(value: 91, label: "3", legend: warmUp),
            .init(value: 130, label: "5", legend: fatBurning),
            .init(value: 135, label: "7", legend: fatBurning),
            .init(value: 136, label: "9", legend: fatBurning),
            .init(value: 138, label: "10", legend: fatBurning),
            .init(value: 150, label: "11", legend: buildFitness),
            .init(value: 151, label: "12", legend: buildFitness),
            .init(value: 150, label: "13", legend: buildFitness),
            .init(value: 136, label: "14", legend: fatBurning),
            .init(value: 130, label: "17", legend: fatBurning),
            .init(value: 150, label: "18", legend: buildFitness),
            .init(value: 150, label: "20", legend: buildFitness),
            .init(value: 160, label: "21", legend: highIntensity),
            .init(value: 158, label: "24", legend: highIntensity),
        ]

        
        
        BarChartView(dataPoints: points, limit: limit)
    }
}

struct HomeView1_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView1(myController: StandZoneController())
        }
    }

}

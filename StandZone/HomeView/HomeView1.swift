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
    @ObservedObject var healthController: HealthViewController
    @State var period: StatisticsType = StatisticsType.Day
    
//    init (myController: StandZoneController, healthController: HealthViewController){
//        self.myController = myController
//        self.healthController = healthController
//
//    }
    var body: some View {
        VStack {
            Picker("Period", selection: $period) {
                    Text("Day").tag(StatisticsType.Day).foregroundColor(Color.white)
                    Text("Week").tag(StatisticsType.Week)
                    Text("Month").tag(StatisticsType.Month)
                    Text("Year").tag(StatisticsType.Year)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .onAppear {
                    UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.green1)
                }
                .onChange(of: period) { type in
                    healthController.performStatisticsQuery(type: type)
                }
            HStack {
                Text("Feb 28, 2022 to today").padding([.leading])
                Spacer()
            }
            FrequencyGraph(myController: myController, healthController: healthController, type: $period)
                .padding()
            TimeGraph()
                .padding()
        }
        .navigationBarTitle("4")
        .navigationBarHidden(true)


 
    }
}



struct FrequencyGraph: View {
    @ObservedObject var myController: StandZoneController
    @ObservedObject var healthController: HealthViewController
    @Binding var type: StatisticsType
        var body: some View {
//        let highIntensity = Legend(color: .orange, label: "High Intensity", order: 5)
//        let buildFitness = Legend(color: .yellow, label: "Build Fitness", order: 4)
        let fatBurning = Legend(color: .green, label: "Fat Burning", order: 3)
//        let warmUp = Legend(color: .blue, label: "Warm Up", order: 2)
//        let low = Legend(color: .gray, label: "Low", order: 1)

        let limit = DataPoint(value: 130, label: "5", legend: fatBurning)
            let points = healthController.generateDataPoint(type: type)
//        let data = healthController.statisticsDisplay
//        let points: [DataPoint] = [
//            .init(value: data[0].value, label: LocalizedStringKey(data[0].label), legend: low),
//                        .init(value: data[1].value, label: LocalizedStringKey(data[1].label), legend: warmUp),
//                        .init(value: data[2].value, label: LocalizedStringKey(data[2].label), legend: warmUp),
//                        .init(value: 10, label: LocalizedStringKey(data[3].label), legend: fatBurning),
//                        .init(value: data[4].value, label: LocalizedStringKey(data[4].label), legend: fatBurning),
//                        .init(value: data[5].value, label: LocalizedStringKey(data[5].label), legend: fatBurning),
//                        .init(value: data[6].value, label: LocalizedStringKey(data[6].label), legend: fatBurning),
            
            
//            .init(value: 70, label: "1", legend: low),
//            .init(value: 90, label: "2", legend: warmUp),
//            .init(value: 91, label: "3", legend: warmUp),
//            .init(value: 130, label: "5", legend: fatBurning),
//            .init(value: 135, label: "7", legend: fatBurning),
//            .init(value: 136, label: "9", legend: fatBurning),
//            .init(value: 138, label: "10", legend: fatBurning),
//            .init(value: 150, label: "11", legend: buildFitness),
//            .init(value: 151, label: "12", legend: buildFitness),
//            .init(value: 150, label: "13", legend: buildFitness),
//            .init(value: 136, label: "14", legend: fatBurning),
//            .init(value: 130, label: "17", legend: fatBurning),
//            .init(value: 150, label: "18", legend: buildFitness),
//            .init(value: 150, label: "20", legend: buildFitness),
//            .init(value: 160, label: "21", legend: highIntensity),
//            .init(value: 158, label: "24", legend: highIntensity),
//        ]

        
        
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
            HomeView1(myController: StandZoneController(), healthController: HealthViewController())
        }
    }

}

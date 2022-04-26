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
                    healthController.performTimeStatisticsQuery(type: type)
                    healthController.performFrequencyStatisticsQuery(type: type)
                }
            ScrollView {

                HStack {
                    Text(getStartingDate(type: period), style: .date).bold().padding([.leading])
                    Text("to today").bold()
                    Spacer()
                }
                TextView()
                    .padding([.top, .leading, .trailing])

                Text("Stand Time")
                    .foregroundColor(.green1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 22))
                    .padding([.top, .leading])
                TimeGraph(myController: myController, healthController: healthController, type: $period)
                    .padding()
                Text("Stand Frequency")
                    .foregroundColor(.green1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 22))
                    .padding(.leading)
                FrequencyGraphV2(myController: myController, healthController: healthController, type: $period)
                    .padding()
            }

        }
        .navigationBarTitle("4")
        .navigationBarHidden(true)


 
    }
    
}

struct TextView: View {
    var body: some View {
 
            Text("Last week, you achieved your goals")
        +    Text(" 2 times. ")
            .foregroundColor(.green1)
            .bold()


            + Text("Your average stand frequency is")
            + Text(" 8 times, ")
                .bold()
                .foregroundColor(.green1)

            + Text("2 times ")
                .bold()
                .foregroundColor(.green1)
            + Text("higher than previous week, ")
        
            + Text("your average daily standing time is")

            + Text(" 65 min, ")
                .bold()
                .foregroundColor(.green1)
            + Text("5 min ")
                .bold()
                .foregroundColor(.green1)
            + Text("higher than previous week, ")
        HStack {
            Text("Excellent!")
                .bold()
                .foregroundColor(.green1)
                .font(.system(size: 26))
            Spacer()
        }
        .padding(.vertical)
        
        Text("However, the frequency of standing per day is not average enough. Pay attention to sticking to it every day is more beneficial to your health")
            .multilineTextAlignment(.leading)
    }
}

struct TimeGraph: View {
    @ObservedObject var myController: StandZoneController
    @ObservedObject var healthController: HealthViewController
    @Binding var type: StatisticsType
        var body: some View {
//        let highIntensity = Legend(color: .orange, label: "High Intensity", order: 5)
//        let buildFitness = Legend(color: .yellow, label: "Build Fitness", order: 4)
//        let fatBurning = Legend(color: .green, label: "Fat Burning", order: 3)
//        let warmUp = Legend(color: .blue, label: "Warm Up", order: 2)
//        let low = Legend(color: .gray, label: "Low", order: 1)

//        let limit = DataPoint(value: Double(myController.getUserInfo().getTimeGoal() * 5), label: "goal", legend: fatBurning)
            let points = myController.generateDataPoint(type: type, category: Category.Time)
        BarChartView(dataPoints: points, limit: nil)
    }
}

struct FrequencyGraphV2: View {
    @ObservedObject var myController: StandZoneController
    @ObservedObject var healthController: HealthViewController
    @Binding var type: StatisticsType
        var body: some View {
//        let highIntensity = Legend(color: .orange, label: "High Intensity", order: 5)
//        let buildFitness = Legend(color: .yellow, label: "Build Fitness", order: 4)
//        let fatBurning = Legend(color: .green, label: "Fat Burning", order: 3)
//        let warmUp = Legend(color: .blue, label: "Warm Up", order: 2)
//        let low = Legend(color: .gray, label: "Low", order: 1)

//        let limit = DataPoint(value: Double(myController.getUserInfo().getTimeGoal() * 5), label: "goal", legend: fatBurning)
            let points = myController.generateDataPoint(type: type, category: Category.Frequency)
        BarChartView(dataPoints: points, limit: nil)
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

struct HomeView1_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView1(myController: StandZoneController(), healthController: HealthViewController())
        }
    }

}

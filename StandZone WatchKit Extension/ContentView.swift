//
//  ContentView.swift
//  StandZone WatchKit Extension
//
//  Created by yifanlan on 3/16/22.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack {
                Text("Stand frequency")
                    .foregroundColor(Color.green)
                ZStack {
                    FrequencyCircle()
                    TimeCircle()
                    CentralMode()
                }
                HStack {
                    Text("Stand time")
                        .foregroundColor(Color.blue)
                }
                HStack {
                    Text("Stand frequency")
                        .foregroundColor(Color.green)
                    Spacer()
                }
                .padding()


                FrequencyGraph()
                HStack {
                    Text("Stand time")
                        .foregroundColor(Color.blue)
                    Spacer()
                }
                .padding()

                TimeGraph()

            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CentralTimer: View {
    var body: some View {
        VStack {
            Text("next stand")
            Text("29:59")
        }
    }
}

struct CentralMode: View {
    var body: some View {
        VStack {
            Text ("Mode")
                .foregroundColor(Color.yellow)
            Image(systemName: "tv")
                .resizable()
    //            .frame(width: 25.0, height: 25.0)
                .foregroundStyle(.yellow)
        }
        .frame(width: 40, height: 50)

    }
}

struct FrequencyCircle : View {
    var body: some View {
        HStack {
            Circle()
               .trim(from: 0.25, to: 1.0)
               .rotation(.degrees(-90))
               .stroke(Color.green ,style: StrokeStyle(lineWidth: 8, lineCap: .butt))
               .frame(width: 110, height: 110)
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
               .stroke(Color.blue ,style: StrokeStyle(lineWidth: 8, lineCap: .butt))
               .frame(width: 94, height: 94)
        }
        .padding()
    }

}

struct FrequencyGraph: View {
    var body: some View {
        let buildFitness = Legend(color: .yellow, label: "Build Fitness", order: 4)
        let fatBurning = Legend(color: .green, label: "Fat Burning", order: 3)
        let warmUp = Legend(color: .blue, label: "Warm Up", order: 2)

        let limit = DataPoint(value: 130, label: "5", legend: fatBurning)

        let points: [DataPoint] = [
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

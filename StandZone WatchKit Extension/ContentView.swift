//
//  ContentView.swift
//  StandZone WatchKit Extension
//
//  Created by yifanlan on 3/16/22.
//

import SwiftUI
import SwiftUICharts
import UserNotifications

struct ContentView: View {
    var body: some View {
        ScrollView {
//            NavigationView {

            VStack {
                Text("Stand frequency")
                    .foregroundColor(Color.green)
                ZStack {
                    FrequencyCircle()
                    TimeCircle()
                    CusModeButton()

//                    NavigationView{
//                        CusModeButton()
//                    }
                }
                MuteModeButton()

            }
//            }
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CusModeButton: View {
    @State private var selection: String? = nil
    var body: some View {
//        NavigationView{
            NavigationLink(destination: SelectionView(), tag: "Cus", selection: $selection) {
                Button(action:{
                    print("Custom Button tapped!")
                    selection = "Cus"
                }) {
                    VStack {
                        Text("Mode")
                        Image(systemName: "tv")
                    }
                }
                .font(.system(size: 15, design: .default))
                .frame(width: 60, height: 20)
                .foregroundColor(Color.yellow)
//        }
//        .frame(width: 60, height: 20)
        }
        .navigationBarTitle("Navigation")
        .frame(width:60, height: 20)
//        .foregroundColor(.white)
}
}

struct MuteModeButton: View {
    @State private var isMute = true
    var body: some View {
        VStack {
            Toggle(isOn: $isMute) {
                Text("Do not disturb")
            }
            .onChange(of: isMute) { _isMute in
                if _isMute {
                    print("Mute Button: Mute Mode")
                }else{
                    print("Mute Button: Send Notification")
                    requestPermission()
                    firstNotification()
                    secondNotification()
                }
            }
        }
        .frame(width: 130)
    }
}

struct SelectionView: View {
    var modeNames = ["Work", "Study", "Sleep", "Mute", "User1", "User2"]
    var imgName = ["person.text.rectangle","brain.head.profile",
                   "bed.double.circle",
                   "bell.slash",
                   "person.crop.circle.fill",
                   "person.crop.circle.fill"]
    @State var selectedMode: String? = nil

    var body: some View {
        List {
            ForEach(0..<6, id:\.self) { i in
                SelectionCell(modeName: modeNames[i],
                              imgName: imgName[i],
                              selectedMode: self.$selectedMode)
            }
        }
    }
}

struct SelectionCell: View {

    let modeName: String
    let imgName: String
    @Binding var selectedMode: String?

    var body: some View {
        HStack {
            HStack {
                Label(modeName, systemImage: imgName)
            }
            Spacer()
            if modeName == selectedMode {
                Image(systemName: "checkmark.circle.fill")
                    .symbolVariant(.circle.fill)
                    .foregroundStyle(.white, .green)
            }
        }.onTapGesture {
            self.selectedMode = self.modeName
        }
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
            Text("Mode")
                .foregroundStyle(.yellow)
            Button {
                requestPermission()
                firstNotification()
                secondNotification()
            } label: {
                Image(systemName: "tv")
                    .resizable()
        //            .frame(width: 25.0, height: 25.0)
                    .foregroundStyle(.yellow)
            }
            .frame(width: 50, height: 40)
        }
        .frame(width: 60, height: 70)

    }
}

func requestPermission() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { (success, error) in
        if success{
        print("All set")
        } else if let error = error {
            print(error.localizedDescription)
        }
    }
}

func firstNotification() {
    let content = UNMutableNotificationContent()
    content.title = "Stand UP!"
    content.body = "Hey, it's time to stand up and move around!🚶🏻‍♂️"
    content.sound = .default
//        content.categoryIdentifier = "myCategory"
//        let category = UNNotificationCategory(identifier: "myCategory", actions: [], intentIdentifiers: [], options: [])
//        UNUserNotificationCenter.current().setNotificationCategories([category])
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
    let request = UNNotificationRequest(identifier: "first", content: content, trigger: trigger)
    UNUserNotificationCenter.current().add(request) { (error) in
        if let error = error{
        print(error.localizedDescription)
        }else{
        print("scheduled successfully 1")
        }
    }
}

func secondNotification(){
    let content = UNMutableNotificationContent()
    content.title = "Hey get up!"
    content.body = "You haven't stood up and moved around. Let's do it to make it a healthier day!😆"
    content.sound = .default
//        content.categoryIdentifier = "myCategory"
//        let category = UNNotificationCategory(identifier: "myCategory", actions: [], intentIdentifiers: [], options: [])
//        UNUserNotificationCenter.current().setNotificationCategories([category])
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 20, repeats: false)
    let request = UNNotificationRequest(identifier: "second", content: content, trigger: trigger)
    UNUserNotificationCenter.current().add(request) { (error) in
        if let error = error{
        print(error.localizedDescription)
        }else{
        print("scheduled successfully 2")
        }
    }
}

struct FrequencyCircle : View {
    var body: some View {
        HStack {
            Circle()
               .trim(from: 0.25, to: 1.0)
               .rotation(.degrees(-90))
               .stroke(Color.green ,style: StrokeStyle(lineWidth: 12, lineCap: .butt))
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
               .stroke(Color.blue ,style: StrokeStyle(lineWidth: 12, lineCap: .butt))
               .frame(width: 87, height: 87)
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

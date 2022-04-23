//
//  ContentView.swift
//  Memorize
//
//  Created by Admin on 3/18/22.
//

import SwiftUI


class User {
    var name: String
    var timeScore: Int
    var freqScore: Int
    var achieveScore: Int
    
    init (name: String, timeScore: Int, freqScore: Int, achieveScore: Int) {
        self.name = name
        self.timeScore = timeScore
        self.freqScore = freqScore
        self.achieveScore = achieveScore
    }
}
// TODO: sorted + rankKeyRefresh + paramPassBetweenView

struct HomeView2: View {
    @ObservedObject var myController: StandZoneController
    @ObservedObject var healthController: HealthViewController
    init(newController: StandZoneController, newHealthController: HealthViewController) {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.green1)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color.green1)], for: .normal)
        myController = newController
        healthController = newHealthController
    }
    
    @State private var selectionIndex = 1
    
    var body: some View {
        VStack (spacing: 0){
            Picker ("Title", selection: $selectionIndex){
                Text("Achievement").tag(1)
                Text("Rank").tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            if selectionIndex == 1{
                achievementView()
//                Spacer()
            } else {
                if myController.getUserInfo().getIsLogIn() == false {
                    AccountView(myController: myController)
                } else {
                    rankView()
                }
            }
        }
    }
}



struct rankView: View {
    @State private var selectedKey = "Time"
    @State private var selection = 1
    @State private var isExpanded = false
    var userNames = ["AAA", "BBB", "Roxanne", "CCC", "DDD", "EEE"]
    var userTimeData = [120, 118, 90, 70, 60, 30]
    var userFreqData = [12, 11, 9, 8, 8, 7]
    var userAchieveData = [6, 5, 4, 3, 2, 1]
    
    var body: some View {
        ZStack {
            Image("background1")
                .resizable()
//                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack (spacing: 0){

                // ADD + Rank Style
    //                topBarView()
                HStack {
                    Image(systemName: "person.fill.badge.plus")
                        .resizable()
                        .frame(width: 25.0, height: 25.0)
                        .foregroundStyle(Color.green2, Color.green2)
                    Spacer()
                    let keyList = ["Time", "Freq", "Badges"]
                    
                    DisclosureGroup(self.selectedKey, isExpanded: $isExpanded) {
                        VStack (spacing: 0){
                            ForEach(0..<3, id: \.self) { num in
                                Text(keyList[num])
                                    .font(.system(size: 12))
                                    .frame(width: 120.0, height: 20.0)
                                    .background(Rectangle().fill(Color.white))
                                    .onTapGesture {
                                        self.selectedKey = keyList[num]
                                        self.isExpanded.toggle()
                                    }
                            }
                        }
                        .border(.gray)
                    }
                    .padding(.horizontal)
                    .accentColor(.green2)
                    .font(Font.headline.weight(.bold))
                    .frame(width: 120, height: 50, alignment: .center)

                }
                .padding(.all)
                
                // FirstOne Profile
                firstProfileView()
                meProfileView(rankKey: self.selectedKey)

                // Ranking List (me first)
                ScrollView {
                    ForEach(0..<6, id:\.self) { i in
                        rankItem(name: userNames[i], rank: i+1, score: userFreqData[i], rankKey: self.selectedKey)
                    }
                }
            }
        }
        .frame(alignment: .top)
    }
}

struct badgeWithPicView: View {

    var contentImgName: String
    var day: String
    var isChecked: Int
    
    
    let badgeSize: Double = 100

    
    var body: some View {
        let checkmarkSize: Double = badgeSize * 40 / 200
        VStack {
            ZStack {
                Image(contentImgName)
                    .resizable()
                    .frame(width: badgeSize, height: badgeSize)
                    .clipShape(Circle())
            
                ZStack {
                    if isChecked == 0 {
                        let checkmark = Circle()
                            .strokeBorder(Color.gray, lineWidth: 1)
                            .background(Circle().foregroundColor(Color.white))
                            .frame(width: checkmarkSize, height: checkmarkSize)
                        checkmark
                    } else if isChecked == 1 {
                        let checkedmark = Image(systemName: "checkmark.circle")
                            .resizable()
                            .symbolVariant(.circle.fill)
                            .foregroundStyle(.white, .blue)
                            .frame(width: checkmarkSize, height: checkmarkSize)
                        checkedmark
                    }
            
                }
                .padding()
                .frame(width: badgeSize+10, height: badgeSize+30, alignment: .topTrailing)
            }
            .frame(width: badgeSize, height: badgeSize+30)
            
            Text (day + " day achieved")
                .padding(.all)
                .frame(width: badgeSize+50, height: 10.0)
                .font(.system(size: 13))
        }
    }
}

struct achievementView: View {
    var imgs = ["world2", "world1", "default", "default", "default", "default", "default", "default", "default"]
    var days = ["1", "3", "7", "14", "21", "30", "60", "100", "365"]
    var checkStatus = [1, 0, 2, 2, 2, 2, 2, 2, 2]
    @State var badgeCount = 9
    
    var body: some View {
        // start
        ZStack {
            Image("Color")
                .resizable()
//                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
//                .border(.red)
            VStack {
                // goal achievement
                HStack {
                    Text("Goal Achievement")
                        .fontWeight(.heavy)
                        .frame(height: 20.0)
                        
                    Spacer()
                }
//                .padding()
//                .border(.red)
                .frame(height: 50.0)

                // badge Grid
                LazyVGrid (columns: [GridItem(), GridItem(), GridItem()]) {
                    ForEach(0..<badgeCount, id:\.self) { i in
                        badgeWithPicView(contentImgName: imgs[i], day: days[i], isChecked: checkStatus[i])
                    }
                }
                .padding(.bottom)
//                .border(.red)
                
                // main navigation
    //            Spacer()
            }
//            .border(.red)
            .padding(/*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/)
            .frame(height: 700, alignment: .top)
        }
        .frame(alignment: .top)
        // end
    }
}

struct keySwitchView: View {
    @State private var selectedKey = "Time"
    @State private var selection = 1
    @State private var isExpanded = false
    
    var keyList = ["Time", "Frequency", "Achievement"]
    
    var body: some View {
        DisclosureGroup(self.selectedKey, isExpanded: $isExpanded) {
            VStack {
                ForEach(0..<3, id: \.self) { num in
                    Text(keyList[num])
                        .font(.title3)
                        .onTapGesture {
                            self.selectedKey = keyList[num]
                            self.isExpanded.toggle()
                        }
                }
            }
        }
        .padding(.horizontal)
        .accentColor(.green)
        .font(Font.headline.weight(.bold))
        .frame(width: 100, alignment: .center)
    }
}

struct topBarView: View {
    var body: some View {
        HStack {
            Image(systemName: "person.fill.badge.plus")
                .resizable()
                .frame(width: 25.0, height: 25.0)
                .foregroundStyle(.green,.green)
            Spacer()
            keySwitchView()

        }
        .padding(.all)
    }
}

struct firstProfileView: View {
    @State private var firstOneName = "Roxanne"
    var body: some View {
        VStack {
            ZStack {
                Image("head")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80) //120 120
                    .clipShape(Circle())
                    .scaledToFill()
//                    .padding()
                ZStack {
                    Image(systemName: "crown")
                        .resizable()
                        .aspectRatio(1.3/1, contentMode: .fill)
                        .foregroundColor(.yellow)
                        .rotationEffect(.degrees(45))
                        .frame(width: 25, height: 25) //35 35
                }
                .frame(width: 100, height: 80, alignment: .topTrailing) //130 120
            }
            .frame(width: 80, height: 80)
            Text(self.firstOneName)
        }
    }
}

struct rankItem: View {
    var name: String
    var rank: Int
    var score: Int
    var rankKey: String
    var scoreColor = Color.green2
    
    var body: some View {
        HStack {
            HStack{
                //rank
                Text(String(rank))
                //img
                Image("head")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .scaledToFill()
                    .padding()
                //name
                Text(name)
            }
            Spacer()
            //score
            HStack {
                if rankKey == "Time" {
                    Text(String(score)) + Text(" mins")
                } else if rankKey == "Badges" {
                    Text(String(score)) + Text(" badges")
                } else {
                    Text(String(score))
                }
            }
            .foregroundColor(scoreColor)
            .font(Font.body.weight(.semibold))
        }
        .frame(width: 300, height: 40)
    }
}
struct meProfileView: View {
    var rankKey: String

    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 10)
            shape.fill()
                .foregroundColor(.green1)
                .frame(height: 60)
                .padding(.all)
            if rankKey == "Time" {
                rankItem(name: "Roxanne", rank: 3, score: 120, rankKey:rankKey, scoreColor: .black)
            } else if rankKey == "Freq" {
                rankItem(name: "Roxanne", rank: 3, score: 90, rankKey: rankKey, scoreColor: .black)
            } else {
                rankItem(name: "Roxanne", rank: 3, score: 4, rankKey: rankKey, scoreColor: .black)
            }
        }

        

    }
}

struct HomeView2_Previews: PreviewProvider {
    static var previews: some View {
        HomeView2(newController: StandZoneController(), newHealthController: HealthViewController())
            .preferredColorScheme(.light)
    }
}

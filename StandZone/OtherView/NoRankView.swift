//
//  NoRankView.swift
//  StandZone
//
//

import SwiftUI

struct NoRankView: View {
    @ObservedObject var myController: StandZoneController
    @Binding var tabSelection: Int
    var body: some View {
        NavigationView {
            ZStack {
                Image("background1")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("If you want to join the ranking with your friends, please open \"Rank\" in \"Setting\"")
                    VStack (spacing: 20){
                        
                            ButtonView(myController: myController, nextScreen: Screen.logInView, content: "Go to setting")
                            .onTapGesture {
                                tabSelection = 3
                            }
                        .buttonStyle(PlainButtonStyle())
                        
                    }.padding()

                }.padding()
            }
        }

        
    }
}

//struct NoRankView_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountView(myController: StandZoneController())
//    }
//}

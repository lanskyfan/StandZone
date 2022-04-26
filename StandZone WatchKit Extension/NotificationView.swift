//
//  NotificationView.swift
//  StandZone WatchKit Extension
//
//  Created by yifanlan on 3/16/22.
//

import SwiftUI

struct NotificationView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var ringAnimation: CGFloat = 0
    @State private var counter = 30
    var count = 30
    var body: some View {
        VStack{
            Text("Hey get up!")
            .font(.title3)
            .fontWeight(.bold)
            Text("You haven't stood up and moved around. Let's do it to make it a healthier day!😆")
            .font(.body)
            ZStack{
            //MARK: - Background Circle
            Circle()
            .stroke(Color.white.opacity(0.1), style: StrokeStyle(lineWidth: 15))
            //MARK: - Progress Circle
            Circle()
            .trim(from: ringAnimation, to: 1.0)
            .stroke(LinearGradient(gradient: Gradient(colors: [.white, .green]), startPoint: .topTrailing, endPoint: .bottomLeading),
            style: StrokeStyle(lineWidth: 15, lineCap: .round))
            .rotationEffect(Angle(degrees: 90))
            .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
            .shadow(color: .blue, radius: 3, x: 0, y: 3)
//            .withAnimation(.easeInOut)
            //MARK: - Percentage
            Text("🚶🏻‍♂️\n\(counter)")
            .font(.title3)
            .multilineTextAlignment(.center)
            }.padding()
            .onAppear{
            updateRing()
            }.frame(minWidth: 100, idealWidth: 110, maxWidth: .infinity, minHeight: 100, idealHeight: 110, maxHeight: .infinity, alignment: .center)
        }
    }
    func updateRing(){
        if counter == 0 {
        self.presentationMode.wrappedValue.dismiss()
        ringAnimation = 10
        return
        }else{
            DispatchQueue.main.asyncAfter(deadline: (.now() + 1)) {
                ringAnimation += CGFloat(1) / CGFloat(count)
                counter -= 1
                updateRing()
            }
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}

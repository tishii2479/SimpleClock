//
//  ClockView.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/04/14.
//

import SwiftUI

struct ClockView: View {
    @ObservedObject var clock = ClockManager.shared
    
    var body: some View {
        ZStack {
            Group {
                // 周りの円
                Circle()
                    .stroke(Color.highBlue, lineWidth: 10)
                    .frame(width: 240, height: 240)
            
                // Rectangleだとギザギザする
                // 分針
//                RoundedRectangle(cornerRadius: 1)
//                    .fill(Color.green)
//                    .frame(width: 4, height: 100)
//                    .offset(x: 0, y: -50)
//                    .rotationEffect(.degrees(clock.minuteAngle))
            
                // 時針
                RoundedRectangle(cornerRadius: 1)
                    .fill(Color.orange)
                    .frame(width: 4, height: 60)
                    .offset(x: 0, y: -30)
                    .rotationEffect(.degrees(clock.hourAngle))
                
                // 中心の円
                Circle()
                    .fill(Color.orange)
                    .frame(width: 10, height: 10)
                
            }
            .edgesIgnoringSafeArea(.all)
            
            // 時刻の表示
            VStack {
                Text(Date.formatTime(date: clock.currentTime))
                    .foregroundColor(.text)
                    .font(.mainFont(size: 100))
                    .minimumScaleFactor(0.1)
                    .shadow(color: .shadow, radius: 5, x: 0, y: 0)
                    .frame(height: 100)
                
                Text(Date.formatDate(date: Date()))
                    .foregroundColor(.text)
                    .font(.mainFont(size: 20))
                    .shadow(color: .shadow, radius: 5, x: 0, y: 0)
                    .padding()
            }
        }
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ClockView()
    }
}

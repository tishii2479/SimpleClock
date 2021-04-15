//
//  ClockView.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/04/14.
//

import SwiftUI

struct ClockView: View {
    @ObservedObject var clock = ClockManager()
    
    var body: some View {
        ZStack {
            Group {
                Circle()
                    .stroke(Color.highBlue, lineWidth: 10)
                    .frame(width: 240, height: 240)
                Circle()
                    .fill(Color.orange)
                    .frame(width: 10, height: 10)
                
                Rectangle()
                    .fill(Color.orange)
                    .frame(width: 4, height: 80)
                    .offset(x: 0, y: -40)
                    .rotationEffect(.degrees(clock.hourAngle))
            }
            .edgesIgnoringSafeArea(.all)
            
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

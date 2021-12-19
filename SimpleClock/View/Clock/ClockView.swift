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
                Circle()
                    .stroke(Color.highBlue, lineWidth: 8)
                    .frame(width: 240, height: 240)
            
                // Use RoundedRectangle() instead of Rectangle(), because
                // Rectangle rendering is not good
                RoundedRectangle(cornerRadius: 1)
                    .fill(Color.orange)
                    .frame(width: 3, height: 60)
                    .offset(x: 0, y: -30)
                    .rotationEffect(.degrees(clock.hourAngle))
                
                RoundedRectangle(cornerRadius: 1)
                    .fill(Color.green)
                    .frame(width: 2, height: 90)
                    .offset(x: 0, y: -50)
                    .rotationEffect(.degrees(clock.minuteAngle))
                
                Circle()
                    .fill(Color.orange)
                    .frame(width: 10, height: 10)
                
            }
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text(clock.currentTime.formatTime())
                    .foregroundColor(.text)
                    .font(.mainFont(size: 90))
                    .minimumScaleFactor(0.1)
                    .shadow(color: .shadow, radius: 5, x: 0, y: 0)
                    .frame(height: 90)
                
                Text(Date().formatDate())
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

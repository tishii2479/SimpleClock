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
            VStack {
                Text(Date.formatTime(date: clock.currentTime))
                    .foregroundColor(.text)
                    .font(.mainFont(size: 80))
                    .shadow(color: .shadow, radius: 5, x: 0, y: 0)
                
                Text(Date.formatDate(date: Date()))
                    .foregroundColor(.text)
                    .font(.mainFont(size: 20))
                    .shadow(color: .shadow, radius: 5, x: 0, y: 0)
                    .padding()
            }
        }
        .onAppear {
            // スリープさせないようにする
            UIApplication.shared.isIdleTimerDisabled = true
        }
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ClockView()
    }
}

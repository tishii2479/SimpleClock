//
//  TimerView.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/04/14.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var viewModel = TimerViewModel()
    @ObservedObject var clock = ClockManager()
    
    var body: some View {
        ZStack {
            VStack {
                Text("00:00:00")
                    .foregroundColor(.text)
                    .font(.mainFont(size: 80))
                    .shadow(color: .shadow, radius: 5, x: 0, y: 0)
                
                Text(Date.formatTime(date: clock.currentTime))
                    .foregroundColor(.text)
                    .font(.mainFont(size: 20))
                    .shadow(color: .shadow, radius: 5, x: 0, y: 0)
                    .padding()
            }
            
            VStack {
                Spacer()
                
                HStack {
                    Button(action: {
                        viewModel.play()
                    }) {
                        MenuItem(systemName: "play", size: 20, isOn: false)
                    }
                    
                    Button(action: {
                        viewModel.pause()
                    }) {
                        MenuItem(systemName: "pause", size: 20, isOn: false)
                    }
                    
                    Button(action: {
                        viewModel.stop()
                    }) {
                        MenuItem(systemName: "stop", size: 20, isOn: false)
                    }
                }
            }
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}

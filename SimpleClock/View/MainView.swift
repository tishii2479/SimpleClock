//
//  MainView.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/04/14.
//

import SwiftUI

struct MainView: View {
    enum ViewType {
        case clock
        case stopwatch
        case timer
    }
    
    @State var currentView: ViewType = .clock
    var clockView = ClockView()
    var stopWatchView = StopWatchView()
    var timerView = TimerView()
    
    var body: some View {
        ZStack {
            switch currentView {
            case .clock:
                clockView
            case .stopwatch:
                stopWatchView
            case .timer:
                timerView
            }
            
            VStack {
                // ヘッダーメニュー
                HStack {
                    MenuItem(systemName: "lock.rotation", size: 30, isOn: false)
                    
                    Spacer()
                    
                    Button(action: {
                        switchView(type: .timer)
                    }) {
                        MenuItem(systemName: "timer", size: 28, isOn: currentView == .timer)
                    }
                    Button(action: {
                        switchView(type: .stopwatch)
                    }) {
                        MenuItem(systemName: "stopwatch", size: 30, isOn: currentView == .stopwatch)
                    }
                    Button(action: {
                        switchView(type: .clock)
                    }) {
                        MenuItem(systemName: "clock", size: 30, isOn: currentView == .clock)
                    }
                    
                    Spacer()
                    
                    MenuItem(systemName: "lock", size: 30, isOn: false)
                }
                
                Spacer()
                
                // フッターメニュー
                HStack {
                    MenuItem(systemName: "rotate.left", size: 28, isOn: false)
                    Spacer()
                    MenuItem(systemName: "rotate.right", size: 28, isOn: false)
                }
            }
        }
        .padding()
    }
    
    func switchView(type: ViewType) {
        currentView = type
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

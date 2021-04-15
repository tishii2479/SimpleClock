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
    
    @State var keepScreenOn: Bool = false
    @State var currentView: ViewType = .clock
    @State var isShowingSetting: Bool = false
    var clockView = ClockView()
    var stopWatchView = StopWatchView()
    var timerView = TimerView()
    
    init() {
        // 背景色をなくす
        UITableView.appearance().backgroundColor = .clear
    }
    
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
                    Button(action: {
                        // スリープさせないようにする
                        keepScreenOn.toggle()
                        UIApplication.shared.isIdleTimerDisabled = keepScreenOn
                    }) {
                        MenuItem(nameOn: "lock", nameOff: "lock.open", size: 30, isOn: keepScreenOn)
                    }
                    
                    Spacer()
                    Button(action: {
                        switchView(type: .clock)
                    }) {
                        MenuItem(name: "clock", size: 30, isOn: currentView == .clock)
                    }
                    Button(action: {
                        switchView(type: .stopwatch)
                    }) {
                        MenuItem(name: "stopwatch", size: 30, isOn: currentView == .stopwatch)
                    }
                    Button(action: {
                        switchView(type: .timer)
                    }) {
                        MenuItem(name: "timer", size: 28, isOn: currentView == .timer)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        isShowingSetting.toggle()
                    }) {
                        MenuItem(name: "line.horizontal.3", size: 30, isOn: false)
                    }
                }
                
                Spacer()
            }
            .padding()
        }
        .sheet(isPresented: $isShowingSetting) {
            SettingView(isShowing: $isShowingSetting)
        }
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

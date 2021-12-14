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
        case activityList
    }
    
    @ObservedObject private var clock = ClockManager.shared
    // Do sleep or not
    @State private var keepScreenOn: Bool = true
    @State private var currentView: ViewType = .clock
    @State private var isShowingSetting: Bool = false
    
    private let clockView = ClockView()
    private let stopWatchView = StopWatchView()
    private let timerView = TimerView()
    private let activityListView = ActivityListView()
    
    init() {
        // Remove background color
        UITableView.appearance().backgroundColor = .clear
        UINavigationBar.appearance().barTintColor = UIColor(.back)
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
            case .activityList:
                activityListView
            }
            
            VStack {
                HStack(spacing: 10) {
                    Button(action: {
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
                    Button(action: {
                        switchView(type: .activityList)
                    }) {
                        MenuItem(name: "list.bullet.rectangle", size: 30, isOn: currentView == .activityList)
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
            
            // Vibrate notification filter
            if clock.isVibrating {
                ZStack {
                    Color(red: 0, green: 0, blue: 0, opacity: clock.isVibrating ? 0.6 : 0)
                    MenuItem(name: "alarm", size: 50, isOn: false)
                }
                .animation(.linear)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    clock.stopVibrate()
                }
            }
        }
        .sheet(isPresented: $isShowingSetting) {
            SettingView(isShowing: $isShowingSetting)
        }
        .onAppear {
            UIApplication.shared.isIdleTimerDisabled = keepScreenOn
        }
    }
    
    private func switchView(type: ViewType) {
        currentView = type
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

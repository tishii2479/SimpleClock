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
    
    @ObservedObject private var clock = Clock()
    @ObservedObject private var notificationManager = NotificationManager.shared
    // Do sleep or not
    @State private var keepScreenOn: Bool = true
    @State private var currentView: ViewType = .clock
    @State private var isShowingSetting: Bool = false
    
    private let clockView = ClockView()
    private let stopWatchView = StopWatchView()
    private let timerView = TimerView()
    private var activityListView = ActivityListView()
    
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
                HStack(spacing: 8) {
                    IconButton(nameOn: "lock", nameOff: "lock.open", size: 28, isOn: keepScreenOn, action: {
                        keepScreenOn.toggle()
                        UIApplication.shared.isIdleTimerDisabled = keepScreenOn
                    })
                    Spacer()
                    IconButton(nameOn: "line.horizontal.3", size: 28, action: {
                        isShowingSetting.toggle()
                    })
                }
                .padding(10)
                .background(
                    // Add bar background when the view is activityList (scrollView)
                    (currentView == .activityList ? Color.back : Color.clear).opacity(0.7).edgesIgnoringSafeArea(.top)
                )
                
                Spacer()
                
                HStack {
                    IconButton(nameOn: "clock", size: 28, isOn: currentView == .clock, action: {
                        switchView(type: .clock)
                    })
                    Spacer()
                    IconButton(nameOn: "stopwatch", size: 31, isOn: currentView == .stopwatch, action: {
                        switchView(type: .stopwatch)
                    })
                    Spacer()
                    IconButton(nameOn: "timer", size: 28, isOn: currentView == .timer, action: {
                        switchView(type: .timer)
                    })
                    Spacer()
                    IconButton(nameOn: "list.bullet.rectangle", size: 28, isOn: currentView == .activityList, action: {
                        switchView(type: .activityList)
                    })
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 10)
                .background(
                    // Add bar background when the view is activityList (scrollView)
                    (currentView == .activityList ? Color.back : Color.clear).opacity(0.7).edgesIgnoringSafeArea(.bottom)
                )
            }
            
            // Vibrate notification filter
            if notificationManager.isVibrating {
                ZStack {
                    Color(red: 0, green: 0, blue: 0, opacity: notificationManager.isVibrating ? 0.6 : 0)
                    IconImageView(nameOn: "alarm", size: 50)
                }
                .animation(.linear)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    notificationManager.stopVibrate()
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

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
    
    @ObservedObject var clock = ClockManager.shared
    // スリープさせないかどうか
    @State var keepScreenOn: Bool = true
    // 今表示している画面
    @State var currentView: ViewType = .clock
    // 設定画面を見せているか（モーダル）
    @State var isShowingSetting: Bool = false
    
    // 各種画面のインスタンス
    var clockView = ClockView()
    var stopWatchView = StopWatchView()
    var timerView = TimerView()
    
    init() {
        // 背景色をなくす
        UITableView.appearance().backgroundColor = .clear
        // スリープしないようにする
        UIApplication.shared.isIdleTimerDisabled = keepScreenOn
    }
    
    var body: some View {
        ZStack {
            // 各種画面
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
                        // スリープするかどうかを設定
                        keepScreenOn.toggle()
                        UIApplication.shared.isIdleTimerDisabled = keepScreenOn
                    }) {
                        MenuItem(nameOn: "lock", nameOff: "lock.open", size: 30, isOn: keepScreenOn)
                    }
                    
                    // 画面切り替えのボタン
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
                    
                    // 設定画面のボタン
                    Button(action: {
                        isShowingSetting.toggle()
                    }) {
                        MenuItem(name: "line.horizontal.3", size: 30, isOn: false)
                    }
                }
                
                Spacer()
            }
            .padding()
            
        
            // 振動通知時の画面（上から覆う）
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

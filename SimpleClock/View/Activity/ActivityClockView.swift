//
//  ActivityClockView.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/12/14.
//

import SwiftUI

struct ActivityClockView: View {
    private enum TimeStyle: String, CaseIterable {
        case current = "現在"
        case today = "今日"
        case total = "通算"

        mutating func next() {
            let allCases = type(of: self).allCases
            self = allCases[(allCases.firstIndex(of: self)! + 1) % allCases.count]
        }
    }
    @ObservedObject private var clock = Clock()
    @ObservedObject var viewModel: ActivityClockViewModel = ActivityClockViewModel()
    @Binding var isShowing: Bool
    @State private var timeStyle: TimeStyle = .current
    
    var body: some View {
        ZStack {
            Color.back
                .edgesIgnoringSafeArea(.all)

            Group {
                Circle()
                    .stroke(Color.light, lineWidth: 8)
                    .frame(width: 240, height: 240)
                
                VStack {
                    Button(action: {
                        timeStyle.next()
                    }) {
                        VStack(spacing: 0) {
                            Text(timeStyle.rawValue)
                                .foregroundColor(.text)
                                .font(.mainFont(size: 14))
                            Text(timeStr)
                                .foregroundColor(.text)
                                .font(.mainFont(size: 90))
                                .minimumScaleFactor(0.1)
                                .frame(height: 90)
                        }
                    }
                    
                    Text(clock.currentTime.formatTime())
                        .foregroundColor(.text)
                        .font(.mainFont(size: 20))
                        .padding()
                }
            }
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    IconButton(nameOn: "lightbulb.fill", action: {
                        viewModel.toggleBrightness()
                    })
                    Spacer()
                    IconButton(nameOn: "multiply", action: {
                        viewModel.onDisappear()
                        isShowing.toggle()
                    })
                }
                Spacer()
                Text(Activity.current.title)
                    .foregroundColor(.text)
                    .font(.mainFont(size: 20))
            }
            .padding(20)
        }
        .onAppear {
            viewModel.onAppear()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification), perform: { output in
            viewModel.onDisappear()
        })
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification), perform: { output in
            viewModel.onRestart()
        })
    }
    
    private var timeStr: String {
        switch timeStyle {
        case .current:
            return TimeFormatter.formatTime(second: viewModel.elapsedTime, style: .semi)
        case .today:
            return viewModel.todayTimeStr
        case .total:
            return viewModel.totalTimeStr
        }
    }
}

struct ActivityClockView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityClockView(isShowing: Binding.constant(true))
    }
}

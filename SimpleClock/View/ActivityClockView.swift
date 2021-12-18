//
//  ActivityClockView.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/12/14.
//

import SwiftUI

struct ActivityClockView: View {
    @ObservedObject private var clock: ClockManager = ClockManager.shared
    @ObservedObject var viewModel: ActivityClockViewModel = ActivityClockViewModel()
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack {
            Color.back
                .edgesIgnoringSafeArea(.all)

            Group {
                Circle()
                    .stroke(Color.light, lineWidth: 8)
                    .frame(width: 240, height: 240)
                
                VStack {
                    Text(viewModel.totalTimeStr)
                        .foregroundColor(.text)
                        .font(.mainFont(size: 100))
                        .minimumScaleFactor(0.1)
                        .shadow(color: .shadow, radius: 5, x: 0, y: 0)
                        .frame(height: 100)
                    
                    Text(clock.currentTime.formatTime())
                        .foregroundColor(.text)
                        .font(.mainFont(size: 20))
                        .shadow(color: .shadow, radius: 5, x: 0, y: 0)
                        .padding()
                }
            }
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Spacer()
                    CloseButton(isShowing: $isShowing, action: {
                        viewModel.onDisappear()
                    })
                }
                Spacer()
            }
            .padding(20)
        }
        .onAppear {
            viewModel.onAppear()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification), perform: { output in
            viewModel.onDisappear()
        })
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification), perform: { output in
            viewModel.onRestart()
        })
    }
}

struct ActivityClockView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityClockView(isShowing: Binding.constant(true))
    }
}

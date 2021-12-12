//
//  StopWatchView.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/04/14.
//

import SwiftUI

struct StopWatchView: View {
    @ObservedObject private var clock: ClockManager = ClockManager.shared
    @ObservedObject private var viewModel = StopWatchViewModel()
    
    var body: some View {
        ZStack {
            Group {
                Circle()
                    .stroke(Color.light, lineWidth: 8)
                    .frame(width: 240, height: 240)
                
                Circle()
                    .trim(from: 0, to: viewModel.circleRatio)
                    .stroke(Color.orange, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .frame(width: 240, height: 240)
                    .rotationEffect(Angle(degrees: -90))
                
                VStack {
                    Text(viewModel.time)
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
                Spacer()
                
                HStack {
                    if viewModel.status == .play {
                        Button(action: {
                            viewModel.pause()
                        }) {
                            MenuItem(name: "pause", size: 20, isOn: false)
                        }
                        .padding(.trailing, 20)
                    } else {
                        Button(action: {
                            viewModel.play()
                        }) {
                            MenuItem(name: "play", size: 20, isOn: false)
                        }
                        .padding(.trailing, 20)
                    }
                    
                    Button(action: {
                        viewModel.stop()
                    }) {
                        MenuItem(name: "stop", size: 20, isOn: false)
                    }
                }
            }
            .padding(.bottom, 20)
        }
    }
}

struct StopWatchView_Previews: PreviewProvider {
    static var previews: some View {
        StopWatchView()
    }
}

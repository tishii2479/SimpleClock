//
//  TimerView.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/04/14.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject private var timer = TimerClock()
    @ObservedObject private var clock = Clock()
    @State private var isShowingPicker = false
    
    var body: some View {
        ZStack {
            Group {
                Circle()
                    .stroke(Color.light, lineWidth: 8)
                    .frame(width: 240, height: 240)
                
                Circle()
                    .trim(from: 0, to: remainingRatio)
                    .stroke(Color.green, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .frame(width: 240, height: 240)
                    .rotationEffect(Angle(degrees: -90))
            }
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                Button(action: {
                    self.isShowingPicker.toggle()
                }) {
                    Text(time)
                        .foregroundColor(.text)
                        .font(.mainFont(size: 90))
                        .minimumScaleFactor(0.1)
                        .frame(height: 90)
                }
                .frame(height: 90)
                .padding(.bottom, 10)
                
                Text(clock.currentTime.formatTime())
                    .foregroundColor(.text)
                    .font(.mainFont(size: 20))
                    .padding(.bottom, 20)
                
                HStack {
                    if timer.status == .play {
                        IconButton(nameOn: "pause", action: {
                            timer.pause()
                        })
                        .padding(.trailing, 30)
                    } else {
                        IconButton(nameOn: "play", action: {
                            timer.play()
                        })
                        .padding(.trailing, 30)
                    }
                    
                    IconButton(nameOn: "stop", action: {
                        timer.stop()
                    })
                }
            }
            
            Color(red: 0, green: 0, blue: 0, opacity: isShowingPicker ? 0.4 : 0)
                .animation(.linear)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    isShowingPicker.toggle()
                }
            
            TimerPicker(viewModel: timer, isShowing: $isShowingPicker)
                .animation(.linear)
                .offset(y: self.isShowingPicker ? 0 : UIScreen.main.bounds.height)
                .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    private var time: String {
        TimeFormatter.formatTime(second: timer.remainingTime, style: .semi)
    }
    
    private var remainingRatio: CGFloat {
        if timer.status == .play || timer.status == .pause {
            return CGFloat(timer.remainingTime) / CGFloat(timer.maxTime)
        } else {
            return 1
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}

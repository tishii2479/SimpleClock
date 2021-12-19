//
//  TimerView.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/04/14.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject private var viewModel = TimerViewModel()
    @ObservedObject private var clock = ClockManager.shared
    
    @State private var isShowingPicker = false
    
    var body: some View {
        ZStack {
            Group {
                Circle()
                    .stroke(Color.light, lineWidth: 8)
                    .frame(width: 240, height: 240)
                
                Circle()
                    .trim(from: 0, to: viewModel.remainingRatio)
                    .stroke(Color.green, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .frame(width: 240, height: 240)
                    .rotationEffect(Angle(degrees: -90))
            }
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                Button(action: {
                    self.isShowingPicker.toggle()
                }) {
                    Text(viewModel.time)
                        .foregroundColor(.text)
                        .font(.mainFont(size: 100))
                        .minimumScaleFactor(0.1)
                        .shadow(color: .shadow, radius: 5, x: 0, y: 0)
                        .frame(height: 100)
                }
                .frame(height: 100)
                
                Text(clock.currentTime.formatTime())
                    .foregroundColor(.text)
                    .font(.mainFont(size: 20))
                    .shadow(color: .shadow, radius: 5, x: 0, y: 0)
                    .padding()
            }
            
            VStack {
                Spacer()

                HStack {
                    if viewModel.status == .play {
                        IconButton(nameOn: "pause", action: {
                            viewModel.pause()
                        })
                        .padding(.trailing, 20)
                    } else {
                        IconButton(nameOn: "play", action: {
                            viewModel.play()
                        })
                        .padding(.trailing, 20)
                    }
                    
                    IconButton(nameOn: "stop", action: {
                        viewModel.stop()
                    })
                }
            }
            .padding(.bottom, 20)
            
            Color(red: 0, green: 0, blue: 0, opacity: isShowingPicker ? 0.4 : 0)
                .animation(.linear)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    isShowingPicker.toggle()
                }
            
            TimerPicker(viewModel: viewModel, isShowing: $isShowingPicker)
                .animation(.linear)
                .offset(y: self.isShowingPicker ? 0 : UIScreen.main.bounds.height)
                .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}

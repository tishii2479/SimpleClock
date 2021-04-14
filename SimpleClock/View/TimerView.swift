//
//  TimerView.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/04/14.
//

import SwiftUI

struct TimerPicker: View {
    var hours = [Int](0 ..< 24)
    var minutes = [Int](0 ..< 60)
    var seconds = [Int](0 ..< 60)
    @ObservedObject var viewModel: TimerViewModel
    @Binding var isShowing: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                Button(action: {
                    self.isShowing = false
                }) {
                    HStack {
                        Spacer()
                        Text("閉じる")
                            .foregroundColor(.text)
                            .font(.mainFont(size: 12))
                            .padding()
                    }
                }
                
                HStack {
                    Picker(selection: $viewModel.hour, label: Text("hour")) {
                        ForEach(0 ..< self.hours.count) { index in
                            Text("\(self.hours[index])")
                                .foregroundColor(.text)
                                .font(.mainFont(size: 14))
                                .tag(index)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 50)
                    .clipped()
                    
                    Picker(selection: $viewModel.minute, label: Text("minute")) {
                        ForEach(0 ..< self.minutes.count) { index in
                            Text("\(self.minutes[index])")
                                .foregroundColor(.text)
                                .font(.mainFont(size: 14))
                                .tag(index)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 50)
                    .clipped()
                    
                    Picker(selection: $viewModel.second, label: Text("second")) {
                        ForEach(0 ..< self.seconds.count) { index in
                            Text("\(self.seconds[index])")
                                .foregroundColor(.text)
                                .font(.mainFont(size: 14))
                                .tag(index)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 50)
                    .clipped()
                }
            }
            .background(Color.back)
            .frame(height: 250)
        }
    }
}

struct TimerView: View {
    @ObservedObject var viewModel = TimerViewModel()
    @ObservedObject var clock = ClockManager()
    
    @State private var isShowingPicker = false
    
    var body: some View {
        ZStack {
            VStack {
                Button(action: {
                    self.isShowingPicker.toggle()
                }) {
                    Text(String(format: "%02d:%02d:%02d", viewModel.hour, viewModel.minute, viewModel.second))
                        .foregroundColor(.text)
                        .font(.mainFont(size: 60))
                        .shadow(color: .shadow, radius: 5, x: 0, y: 0)
                        .padding()
                }
                .frame(height: 80)
                
                Text(Date.formatTime(date: clock.currentTime))
                    .foregroundColor(.text)
                    .font(.mainFont(size: 20))
                    .shadow(color: .shadow, radius: 5, x: 0, y: 0)
                    .padding()
            }
            
            VStack {
                Spacer()

                HStack {
                    Button(action: {
                        viewModel.play()
                    }) {
                        MenuItem(systemName: "play", size: 20, isOn: false)
                    }
                    .padding(.trailing, 20)
                    
                    Button(action: {
                        viewModel.pause()
                    }) {
                        MenuItem(systemName: "pause", size: 20, isOn: false)
                    }
                    .padding(.trailing, 20)
                    
                    Button(action: {
                        viewModel.stop()
                    }) {
                        MenuItem(systemName: "stop", size: 20, isOn: false)
                    }
                }
            }
            .padding(.bottom, 50)
            
            // マスク
            Color(red: 0, green: 0, blue: 0, opacity: isShowingPicker ? 0.4 : 0)
                .animation(.linear)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    isShowingPicker.toggle()
                }
            
            TimerPicker(viewModel: viewModel, isShowing: $isShowingPicker)
                .animation(.linear)
                .offset(y: self.isShowingPicker ? 0 : UIScreen.main.bounds.height)
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}

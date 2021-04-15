//
//  TimerPicker.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/04/15.
//

import SwiftUI

struct TimerPicker: View {
    var hours = [Int](0 ..< 24)
    var minutes = [Int](0 ..< 60)
    var seconds = [Int](0 ..< 60)
    @ObservedObject var viewModel: TimerViewModel
    // 表示しているかどうか
    @Binding var isShowing: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                // 閉じるボタン
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
                    // 時間のピッカー
                    Picker(selection: $viewModel.selectedHour, label: Text("hour")) {
                        ForEach(0 ..< self.hours.count) { index in
                            Text(String(format: "%02d", self.hours[index]))
                                .foregroundColor(.text)
                                .font(.mainFont(size: 16))
                                .tag(index)
                        }
                    }
                    .onChange(of: viewModel.selectedHour, perform: { value in
                        viewModel.onChange()
                    })
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 60)
                    .clipped()
                    
                    Text(":")
                        .foregroundColor(.text)
                        .font(.mainFont(size: 16))
                    
                    // 分のピッカー
                    Picker(selection: $viewModel.selectedMinute, label: Text("minute")) {
                        ForEach(0 ..< self.minutes.count) { index in
                            Text(String(format: "%02d", self.minutes[index]))
                                .foregroundColor(.text)
                                .font(.mainFont(size: 16))
                                .tag(index)
                        }
                    }
                    .onChange(of: viewModel.selectedMinute, perform: { value in
                        viewModel.onChange()
                    })
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 60)
                    .clipped()
                    
                    Text(":")
                        .foregroundColor(.text)
                        .font(.mainFont(size: 16))
                    
                    // 秒のピッカー
                    Picker(selection: $viewModel.selectedSecond, label: Text("second")) {
                        ForEach(0 ..< self.seconds.count) { index in
                            Text(String(format: "%02d", self.seconds[index]))
                                .foregroundColor(.text)
                                .font(.mainFont(size: 16))
                                .tag(index)
                        }
                    }
                    .onChange(of: viewModel.selectedSecond, perform: { value in
                        viewModel.onChange()
                    })
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 60)
                    .clipped()
                }
            }
            .background(Color.back)
            .frame(height: 240)
        }
    }
}

struct TimerPicker_Previews: PreviewProvider {
    static var previews: some View {
        TimerPicker(viewModel: TimerViewModel(), isShowing: Binding.constant(true))
    }
}

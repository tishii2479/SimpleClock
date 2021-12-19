//
//  TimerPicker.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/04/15.
//

import SwiftUI

struct TimerPicker: View {
    private let hours = [Int](0 ..< 24)
    private let minutes = [Int](0 ..< 60)
    private let seconds = [Int](0 ..< 60)
    @ObservedObject var viewModel: TimerViewModel
    @Binding var isShowing: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                HStack {
                    Spacer()
                    IconButton(nameOn: "multiply", size: 18, action: {
                        isShowing.toggle()
                    })
                    .padding(10)
                }
                
                HStack {
                    Picker(selection: $viewModel.selectedHour, label: Text("hour")) {
                        ForEach(0 ..< self.hours.count) { index in
                            Text(String(format: "%02d", self.hours[index]))
                                .foregroundColor(.text)
                                .font(.mainFont(size: 16))
                                .tag(index)
                        }
                    }
                    .onChange(of: viewModel.selectedHour, perform: { value in
                        viewModel.onPickerChange()
                    })
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 60)
                    .clipped()
                    
                    Text(":")
                        .foregroundColor(.text)
                        .font(.mainFont(size: 16))
                    
                    Picker(selection: $viewModel.selectedMinute, label: Text("minute")) {
                        ForEach(0 ..< self.minutes.count) { index in
                            Text(String(format: "%02d", self.minutes[index]))
                                .foregroundColor(.text)
                                .font(.mainFont(size: 16))
                                .tag(index)
                        }
                    }
                    .onChange(of: viewModel.selectedMinute, perform: { value in
                        viewModel.onPickerChange()
                    })
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 60)
                    .clipped()
                    
                    Text(":")
                        .foregroundColor(.text)
                        .font(.mainFont(size: 16))
                    
                    Picker(selection: $viewModel.selectedSecond, label: Text("second")) {
                        ForEach(0 ..< self.seconds.count) { index in
                            Text(String(format: "%02d", self.seconds[index]))
                                .foregroundColor(.text)
                                .font(.mainFont(size: 16))
                                .tag(index)
                        }
                    }
                    .onChange(of: viewModel.selectedSecond, perform: { value in
                        viewModel.onPickerChange()
                    })
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 60)
                    .clipped()
                }
                
                Spacer().frame(height: 60)
            }
            .background(Color.back)
            .frame(height: 300)
        }
    }
}

struct TimerPicker_Previews: PreviewProvider {
    static var previews: some View {
        TimerPicker(viewModel: TimerViewModel(), isShowing: Binding.constant(true))
    }
}

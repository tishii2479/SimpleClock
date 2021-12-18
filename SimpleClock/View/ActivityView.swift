//
//  ActivityView.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/12/14.
//

import SwiftUI

struct ActivityView: View {
    @Binding var isShowing: Bool
    @State private var isShowingClock: Bool = false
    @ObservedObject private var viewModel: ActivityViewModel = ActivityViewModel()
    
    var body: some View {
        ZStack {
            Color.back
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                Spacer().frame(height: 80)
                
                VStack(spacing: 30) {
                    HStack {
                        Text("総時間")
                            .foregroundColor(.text)
                            .font(.mainFont(size: 20))
                        
                        Text(viewModel.totalTimeStr)
                            .foregroundColor(.text)
                            .font(.mainFont(size: 14))
                            .padding(.leading, 20)
                        
                        Spacer()
                    }
                    
                    HistoryChartView()
                        .frame(maxWidth: .infinity, idealHeight: 240)
                    
                    // TODO: Github activity
                    
                    HStack {
                        Text("合計日数")
                            .foregroundColor(.text)
                    }
                    
                    // TODO: Delete button
                    Button(action: {
                        print("Delete")
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .frame(width: 200, height: 50)
                                .foregroundColor(.red)

                            Text("Delete")
                                .foregroundColor(.white)
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            
            VStack {
                HStack {
                    Text(viewModel.activity.title)
                        .foregroundColor(.text)
                        .font(.mainFont(size: 30))
                    
                    Spacer()
                    
                    Text("今月 " + viewModel.monthTimeStr)
                        .foregroundColor(.text)
                        .font(.mainFont(size: 16))
                        .padding(.trailing, 20)
                    
                    Button(action: {
                        isShowing.toggle()
                    }) {
                        Image(systemName: "multiply")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.on)
                    }
                    .padding(5)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(
                    Color.back.opacity(0.5).edgesIgnoringSafeArea(.top)
                )

                Spacer()

                Button(action: {
                    isShowingClock.toggle()
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .frame(width: 200, height: 50)
                            .foregroundColor(.white)
                            .shadow(radius: 10)

                        Text("Start")
                            .foregroundColor(.black)
                    }
                }
                .padding(20)
            }
        }
        .fullScreenCover(isPresented: $isShowingClock, onDismiss: {
            viewModel.updateActivity()
        }) {
            ActivityClockView(isShowing: $isShowingClock)
        }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView(isShowing: Binding.constant(true))
    }
}

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
    @EnvironmentObject private var activityManager: ActivityManager
    
    var body: some View {
        ZStack {
            Color.back
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                Spacer().frame(height: 80)
                
                HStack {
                    Text("総時間")
                        .foregroundColor(.text)
                        .font(.mainFont(size: 20))
                    
                    Text(activityManager.currentActivity.totalTimeStr)
                        .foregroundColor(.text)
                        .font(.mainFont(size: 14))
                        .padding(.leading, 20)
                    
                    Spacer()
                }
                
                Rectangle()
                    .foregroundColor(.black)
                    .frame(width: 300, height: 240)
                
                Rectangle()
                    .foregroundColor(.black)
                    .frame(width: 300, height: 200)
                
                Rectangle()
                    .foregroundColor(.black)
                    .frame(width: 300, height: 200)
            }
            .padding(.horizontal, 20)
            
            VStack {
                HStack {
                    Text(activityManager.currentActivity.title)
                        .foregroundColor(.text)
                        .font(.mainFont(size: 30))
                    
                    Spacer()
                    
                    Text("今月 " + activityManager.currentActivity.monthTimeStr)
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
            }
            .padding(20)
        }
        .fullScreenCover(isPresented: $isShowingClock) {
            ActivityClockView(isShowing: $isShowingClock)
        }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView(isShowing: Binding.constant(true))
    }
}
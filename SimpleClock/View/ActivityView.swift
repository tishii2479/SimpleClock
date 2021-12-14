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
    var activity: Activity = Activity(id: 0)
    
    var body: some View {
        ZStack {
            Color.back
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                Spacer().frame(height: 60)
                Text("総時間")
                    .foregroundColor(.text)
                    .font(.mainFont(size: 24))
                
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
                    Text(activity.title)
                        .foregroundColor(.text)
                        .font(.mainFont(size: 24))
                    
                    Spacer()
                    
                    Text("今月 130h")
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
                    Text("Start")
                        .foregroundColor(.text)
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

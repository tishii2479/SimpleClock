//
//  ContentView.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/04/14.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.back
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("23:12:30")
                    .foregroundColor(.text)
                    .font(.mainFont(size: 80))
                    .shadow(color: .shadow, radius: 5, x: 0, y: 0)
            }
            
            VStack {
                HStack {
                    Image(systemName: "lock.rotation")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.text)
                        .shadow(color: .shadow, radius: 4, x: 0, y: 0)
                    Image(systemName: "timer")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.text)
                        .shadow(color: .shadow, radius: 4, x: 0, y: 0)
                    Image(systemName: "stopwatch")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.text)
                        .shadow(color: .shadow, radius: 4, x: 0, y: 0)

                }
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

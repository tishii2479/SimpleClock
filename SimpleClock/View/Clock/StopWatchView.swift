//
//  StopWatchView.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/04/14.
//

import SwiftUI

struct StopWatchView: View {
    @ObservedObject private var clock = Clock()
    @ObservedObject private var stopWatch = StopWatch()
    
    var body: some View {
        ZStack {
            Group {
                Circle()
                    .stroke(Color.light, lineWidth: 8)
                    .frame(width: 240, height: 240)
                
                Circle()
                    .trim(from: 0, to: circleRatio)
                    .stroke(Color.orange, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .frame(width: 240, height: 240)
                    .rotationEffect(Angle(degrees: -90))
                
                VStack {
                    Text(time)
                        .foregroundColor(.text)
                        .font(.mainFont(size: 90))
                        .minimumScaleFactor(0.1)
                        .frame(height: 90)
                        .padding(.bottom, 10)
                    
                    Text(clock.currentTime.formatTime())
                        .foregroundColor(.text)
                        .font(.mainFont(size: 20))
                        .padding(.bottom, 20)
                    
                    HStack {
                        if stopWatch.status == .play {
                            IconButton(nameOn: "pause", action: {
                                stopWatch.pause()
                            })
                            .padding(.trailing, 30)
                        } else {
                            IconButton(nameOn: "play", action: {
                                stopWatch.play()
                            })
                            .padding(.trailing, 30)
                        }
                        
                        IconButton(nameOn: "stop", action: {
                            stopWatch.stop()
                        })
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    private var time: String {
        TimeFormatter.formatTime(centSecond:stopWatch.elapsedTime, style: .semi)
    }
    
    private var circleRatio: CGFloat {
        if stopWatch.status == .play || stopWatch.status == .pause {
            return CGFloat(stopWatch.elapsedTime % 6000) / CGFloat(6000)
        } else {
            return 1
        }
    }
}

struct StopWatchView_Previews: PreviewProvider {
    static var previews: some View {
        StopWatchView()
    }
}

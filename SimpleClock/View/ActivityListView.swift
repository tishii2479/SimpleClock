//
//  ActivityListView.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/12/14.
//

import SwiftUI

private struct ActivityListCellView: View {
    var activity: Activity
    var body: some View {
        ZStack {
            HStack {
                VStack(alignment: .leading, spacing: 20) {
                    Text(activity.title)
                        .foregroundColor(.text)
                        .font(.mainFont(size: 18))

                    Text("総時間 123h 30m")
                        .foregroundColor(.text)
                        .font(.mainFont(size: 14))
                    
                    Text("今月 30h 22m")
                        .foregroundColor(.text)
                        .font(.mainFont(size: 14))
                }
                Spacer()
                
                Color.black
                    .frame(width: 150)
            }
            .padding(20)
        }
        .frame(maxWidth: .infinity)
        .border(Color.white)
    }
}

struct ActivityListView: View {
    @State private var isShowingActivity: Bool = false
    var body: some View {
        ScrollView {
            Spacer().frame(height: 80)

            ForEach(0 ..< 3) { _ in 
                Button(action: {
                    isShowingActivity.toggle()
                }) {
                    ActivityListCellView(activity: Activity(id: 0))
                }
            }
        }
        .padding(.horizontal, 20)
        .fullScreenCover(isPresented: $isShowingActivity) {
            ActivityView(isShowing: $isShowingActivity)
        }
    }
}

struct ActivityListView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityListView()
    }
}

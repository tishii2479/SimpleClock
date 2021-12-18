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

                    Text("総時間 " + activity.totalTimeStr)
                        .foregroundColor(.text)
                        .font(.mainFont(size: 14))
                    
                    Text("今月 " + activity.monthTimeStr)
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
    @State private var activities = Activity.all
    var body: some View {
        ScrollView {
            Spacer().frame(height: 80)

            ForEach(activities, id: \.hashValue) { activity in
                Button(action: {
                    Activity.current = activity
                    isShowingActivity.toggle()
                }) {
                    ActivityListCellView(activity: activity)
                }
            }
        }
        .padding(.horizontal, 20)
        .fullScreenCover(isPresented: $isShowingActivity, onDismiss: {
            // Refresh activities
            activities = Activity.all
        }) {
            ActivityView(isShowing: $isShowingActivity)
        }
    }
}

struct ActivityListView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityListView()
    }
}

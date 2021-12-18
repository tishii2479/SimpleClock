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
        .border(Color.border, width: 2)
    }
}

struct ActivityListView: View {
    @State private var isShowingActivity: Bool = false
    @State private var isShowingCreateActivityAlert: Bool = false
    @State private var newActivityName: String = ""
    @State private var activities = Activity.all
    var body: some View {
        ScrollView {
            Spacer().frame(height: 80)

            VStack(spacing: 20) {
                ForEach(activities, id: \.hashValue) { activity in
                    Button(action: {
                        Activity.current = activity
                        isShowingActivity.toggle()
                    }) {
                        ActivityListCellView(activity: activity)
                    }
                }
                
                Button(action: {
                    isShowingCreateActivityAlert.toggle()
                }) {
                    ZStack {
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.on)
                    }
                    .frame(maxWidth: .infinity, idealHeight: 70)
                    .border(Color.on, width: 1)
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

        if isShowingCreateActivityAlert {
            TextFieldAlertView(
                text: $newActivityName,
                isShowingAlert: $isShowingCreateActivityAlert,
                placeholder: "名前",
                isSecureTextEntry: false,
                title: "新しいアクティビティの作成",
                message: "アクティビティの名前を入力",
                leftButtonTitle: "キャンセル",
                rightButtonTitle: "作成",
                leftButtonAction: nil,
                rightButtonAction: {
                    Activity.create(title: newActivityName)
                    newActivityName = ""
                    activities = Activity.all
            })
        }
    }
}

struct ActivityListView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityListView()
    }
}

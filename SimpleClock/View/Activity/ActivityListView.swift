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
                    
                    HStack {
                        Text("総時間")
                            .foregroundColor(.text)
                            .font(.mainFont(size: 12))
                        Text(activity.totalTimeStr)
                            .foregroundColor(.text)
                            .font(.mainFont(size: 20))
                    }
                    
                    HStack {
                        Text("今月")
                            .foregroundColor(.text)
                            .font(.mainFont(size: 12))
                        Text(activity.monthTimeStr)
                            .foregroundColor(.text)
                            .font(.mainFont(size: 20))
                    }
                }
                Spacer()
                
                ActivityGridView(activity: Binding.constant(activity), xCount: 10, showDate: false, defaultWidth: 140)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 10)
    }
}

struct ActivityListView: View {
    @State private var isShowingActivity: Bool = false
    @State private var isShowingCreateActivityAlert: Bool = false
    @State private var newActivityName: String = ""
    @State private var activities = Activity.all
    var body: some View {
        ScrollView(showsIndicators: false) {
            Spacer().frame(height: 80)

            VStack(spacing: 20) {
                Color.light.frame(height: 2)
                ForEach(activities, id: \.hashValue) { activity in
                    Button(action: {
                        Activity.current = activity
                        isShowingActivity.toggle()
                    }) {
                        ActivityListCellView(activity: activity)
                    }
                    Color.light.frame(height: 2)
                }
                
                Button(action: {
                    isShowingCreateActivityAlert.toggle()
                }) {
                    ZStack {
                        IconImageView(nameOn: "plus")
                    }
                    .frame(maxWidth: .infinity, minHeight: 60, idealHeight: 60)
                }
                Color.light.frame(height: 2)

                Spacer().frame(height: 60)
            }
            .padding(10)
        }
        .padding(.horizontal, 10)
        .sheet(isPresented: $isShowingActivity, onDismiss: {
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

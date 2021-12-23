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
    @State private var isShowingDeleteAlert: Bool = false
    @State private var isShowingRenameActivityAlert: Bool = false
    @State private var newActivityName: String = ""
    @ObservedObject private var viewModel: ActivityViewModel = ActivityViewModel()
    
    var body: some View {
        ZStack {
            Color.back
                .edgesIgnoringSafeArea(.all)
            
            ScrollView(showsIndicators: false) {
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

                        Menu(content: {
                            Button("アクティビティの名前を変更", action: {
                                isShowingRenameActivityAlert.toggle()
                            })
                            Button("アクティビティを削除", action: {
                                isShowingDeleteAlert.toggle()
                            })
                        }) {
                            IconImageView(nameOn: "ellipsis")
                        }
                    }
                    
                    ActivityHistoryChartView(activity: $viewModel.activity)
                        .frame(maxWidth: .infinity, idealHeight: 240)
                    
                    HStack {
                        Text("活動履歴")
                            .foregroundColor(.text)
                            .font(.mainFont(size: 20))

                        Spacer()
                    }
                    
                    ActivityGridView(activity: $viewModel.activity)

                    VStack(spacing: 10) {
                        StatusTextRowView(
                            leftText: "1日あたりの平均時間",
                            rightText: TimeFormatter.formatTime(second: viewModel.activity.averageSecondPerDay, style: .hms)
                        )

                        StatusTextRowView(
                            leftText: "連続継続日数",
                            rightText: String(viewModel.activity.consecutiveDayCount) + "d"
                        )

                        StatusTextRowView(
                            leftText: "合計日数",
                            rightText: String(viewModel.activity.totalDate) + "d"
                        )
                    }

                    Spacer().frame(height: 90)
                }
            }
            .padding(.horizontal, 20)
            
            VStack {
                HStack {
                    Text(viewModel.activityName)
                        .foregroundColor(.text)
                        .font(.mainFont(size: 30))
                        .lineLimit(1)
                    
                    Spacer()
                    
                    Text("今月 " + viewModel.monthTimeStr)
                        .foregroundColor(.text)
                        .font(.mainFont(size: 16))
                        .padding(.trailing, 20)
                    
                    IconButton(nameOn: "multiply", action: {
                        isShowing.toggle()
                    })
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(
                    Color.back.opacity(0.7).edgesIgnoringSafeArea(.top)
                )

                Spacer()

                HStack {
                    Spacer()
                    Button(action: {
                        isShowingClock.toggle()
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .frame(width: 120, height: 50)
                                .foregroundColor(.orange)
                                .shadow(color: .black, radius: 5, x: 0, y: 4)

                            HStack {
                                Text("開始")
                                    .foregroundColor(.text)
                                    .font(.mainFont(size: 16))
                                
                                IconImageView(nameOn: "stopwatch")
                            }
                        }
                    }
                }
                .padding(20)
            }
        }
        .alert(isPresented: $isShowingDeleteAlert) {
            Alert(title: Text("このアクティビティを削除しますか？"),
                  primaryButton: .cancel(Text("キャンセル")),
                  secondaryButton: .destructive(Text("削除"),
                  action: {
                    isShowing.toggle()
                    viewModel.activity.delete()
                  })
            )
        }
        .fullScreenCover(isPresented: $isShowingClock, onDismiss: {
            viewModel.updateActivity()
        }) {
            ActivityClockView(isShowing: $isShowingClock)
        }
        
        if isShowingRenameActivityAlert {
            TextFieldAlertView(
                text: $newActivityName,
                isShowingAlert: $isShowingRenameActivityAlert,
                placeholder: "新しい名前",
                isSecureTextEntry: false,
                title: "アクティビティの名前の変更",
                message: "アクティビティの新しい名前を入力",
                leftButtonTitle: "キャンセル",
                rightButtonTitle: "変更",
                leftButtonAction: nil,
                rightButtonAction: {
                    if newActivityName == "" { return }
                    viewModel.activity.rename(newName: newActivityName)
                    newActivityName = ""
                    viewModel.updateActivity()
            })
        }
    }
    
    private struct StatusTextRowView: View {
        var leftText: String
        var rightText: String
        var body: some View {
            HStack(spacing: 20) {
                Text(leftText)
                    .foregroundColor(.text)
                    .font(.mainFont(size: 12))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
                Text(rightText)
                    .foregroundColor(.text)
                    .font(.mainFont(size: 20))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView(isShowing: Binding.constant(true))
    }
}

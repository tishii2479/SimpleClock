//
//  SettingView.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/04/15.
//

import SwiftUI

struct SettingView: View {
    // 表示しているか
    @Binding var isShowing: Bool
    
    @State var isShowingTutorial: Bool = false
        
    var body: some View {
        // アプリバージョン
        let version: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        return ZStack {
            // 背景
            Color.back
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // 閉じるボタン
                Button(action: {
                    self.isShowing = false
                }) {
                    HStack {
                        Spacer()
                        Text("閉じる")
                            .foregroundColor(.text)
                            .font(.mainFont(size: 16))
                            .padding()
                    }
                }
                .background(Color.light)
                
                // 各種設定
                Form {
//                    Section(header: Text("一般").foregroundColor(.text)) {
//                        // チュートリアル
//                        Button(action: {
//                            self.isShowingTutorial.toggle()
//                        }) {
//                            HStack {
//                                Text("使い方")
//                                    .foregroundColor(.text)
//                                Spacer()
//                            }
//                        }
//                        .buttonStyle(BorderlessButtonStyle())
//                        .fullScreenCover(isPresented: $isShowingTutorial) {
//                            TutorialView(isShowing: $isShowingTutorial)
//                        }
//                    }
//                    .listRowBackground(Color.back)
                    
                    Section(header: Text("このアプリについて").foregroundColor(.text)) {
                        HStack {
                            Text("バージョン")
                            Spacer()
                            Text(version)
                                .fontWeight(.light)
                        }
                        .foregroundColor(Color.text)
                        
                        HStack {
                            Text("開発者")
                            Spacer()
                            Text("@tishii2479")
                                .fontWeight(.light)
                        }
                        .foregroundColor(Color.text)
                    }
                    .listRowBackground(Color.back)
                }
                .padding()
            }
            .background(Color.light)
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(isShowing: Binding.constant(true))
    }
}

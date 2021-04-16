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
    @State var isShowingText: Bool = false
    @State var showingText: String = ""
    
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
                
                // 各種設定
                Form {
                    Section(header: Text("このアプリについて").foregroundColor(.text)) {
                        HStack {
                            Text("バージョン")
                            Spacer()
                            Text(version)
                                .fontWeight(.light)
                        }
                        .foregroundColor(Color.text)
                        
                        Button(action: {
                            showingText = TextData.termOfUse
                            self.isShowingText.toggle()
                        }) {
                            Text("利用規約")
                                .foregroundColor(Color.text)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Button(action: {
                            showingText = TextData.privacyPolicy
                            self.isShowingText.toggle()
                        }) {
                            Text("プライバシーポリシー")
                                .foregroundColor(Color.text)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        HStack {
                            Text("開発者")
                            Spacer()
                            Text("@tishii2479")
                                .fontWeight(.light)
                        }
                        .foregroundColor(Color.text)
                    }
                    .listRowBackground(Color.light)
                }
                .sheet(isPresented: $isShowingText) {
                    TextView(isShowing: $isShowingText, text: $showingText)
                }
            }
            .padding()
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(isShowing: Binding.constant(true))
    }
}

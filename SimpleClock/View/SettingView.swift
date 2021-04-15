//
//  SettingView.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/04/15.
//

import SwiftUI

struct SettingView: View {
    @Binding var isShowing: Bool
        
    var body: some View {
        let version: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        return ZStack {
            Color.back
                .edgesIgnoringSafeArea(.all)
            VStack {
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
                
                Form {
//                    Section(header: Text("一般").foregroundColor(Color.text)) {
//                        Toggle("時刻の24時間表示", isOn: Binding.constant(true))
//                            .foregroundColor(Color.text)
//
//                        Toggle("ライト", isOn: Binding.constant(false))
//                            .foregroundColor(Color.text)
//                    }
//                    .listRowBackground(Color.back)
                    
                    Section(header: Text("このアプリについて").foregroundColor(Color.text)) {
                        HStack {
                            Text("バージョン")
                            Spacer()
                            Text(version)
                        }
                        .foregroundColor(Color.text)
                        
                        HStack {
                            Text("製作者")
                            Spacer()
                            Text("@tishii2479")
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

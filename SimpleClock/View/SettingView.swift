//
//  SettingView.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/04/15.
//

import SwiftUI

struct SettingView: View {
    init() {
        // 背景色をなくす
        UITableView.appearance().backgroundColor = .clear
    }
    var body: some View {
        ZStack {
            Color.back
                .edgesIgnoringSafeArea(.all)
            Form {
                TextField("aa", text: Binding.constant("asdf"))
                    .foregroundColor(.text)
                    .listRowBackground(Color.back)
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

//
//  SimpleClockApp.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/04/14.
//

import SwiftUI

@main
struct SimpleClockApp: SwiftUI.App {
    init() {
        RealmManager.start()
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                Color.back
                    .edgesIgnoringSafeArea(.all)
                MainView()
            }
            .statusBar(hidden: true)
        }
    }
}

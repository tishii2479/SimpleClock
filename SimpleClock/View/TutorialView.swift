//
//  TutorialView.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/04/16.
//

import SwiftUI

struct TutorialView: View {
    var body: some View {
        ZStack {
            Color.back
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                TabView {
                    Image("Tutorial1")
                        .resizable()
                        .scaledToFit()
                    Image("Tutorial2")
                        .resizable()
                        .scaledToFit()
                    Image("Tutorial3")
                        .resizable()
                        .scaledToFit()
                }
                .tabViewStyle(PageTabViewStyle())
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
    }
}

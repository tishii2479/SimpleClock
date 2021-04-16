//
//  TutorialView.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/04/16.
//

import SwiftUI

struct TutorialView: View {
    @Binding var isShowing: Bool
    var body: some View {
        ZStack {
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
        TutorialView(isShowing: Binding.constant(true))
    }
}

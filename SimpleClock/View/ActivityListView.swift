//
//  ActivityListView.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/12/14.
//

import SwiftUI

private struct ActivityListCellView: View {
    var body: some View {
        ZStack {
            HStack {
                VStack(alignment: .leading, spacing: 20) {
                    Text("機械学習の勉強")
                        .foregroundColor(.text)
                        .font(Font.mainFont(size: 18))

                    Text("総時間 123h 30m")
                        .foregroundColor(.text)
                        .font(Font.mainFont(size: 14))
                    
                    Text("今月 30h 22m")
                        .foregroundColor(.text)
                        .font(Font.mainFont(size: 14))
                }
                Spacer()
                
                Color.black
                    .frame(width: 150)
            }
            .padding(20)
        }
        .frame(maxWidth: .infinity)
        .border(Color.white)
    }
}

struct ActivityListView: View {
    var body: some View {
        ScrollView {
            Spacer().frame(height: 80)

            Button(action: {
                print("Button action")
            }) {
                ActivityListCellView()
            }
            ActivityListCellView()
            ActivityListCellView()
        }
        .padding(.horizontal, 20)
    }
}

struct ActivityListView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityListView()
    }
}

//
//  CloseButton.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/12/18.
//

import SwiftUI

struct CloseButton: View {
    @Binding var isShowing: Bool
    var action: (() -> Void)?
    var body: some View {
        Button(action: {
            action?()
            isShowing.toggle()
        }) {
            Image(systemName: "multiply")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundColor(.on)
        }
        .padding(5)
    }
}

struct CloseButton_Previews: PreviewProvider {
    static var previews: some View {
        CloseButton(isShowing: Binding.constant(true), action: {})
    }
}

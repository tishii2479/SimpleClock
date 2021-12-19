//
//  IconButton.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/12/18.
//

import SwiftUI

struct IconButton: View {
    var nameOn: String
    var nameOff: String?
    var size: CGFloat = 20
    var isOn: Bool = true
    var action: (() -> Void)
    var body: some View {
        Button(action: action) {
            IconImageView(nameOn: nameOn, nameOff: nameOff, size: size, isOn: isOn)
        }
        .padding(5)
    }
}

struct IconButton_Previews: PreviewProvider {
    static var previews: some View {
        IconButton(nameOn: "clock", action: {})
    }
}

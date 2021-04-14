//
//  View.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/04/14.
//

import SwiftUI

extension View {
    func MenuItem(systemName: String, size: CGFloat, isOn: Bool) -> some View {
        return ZStack {
            Image(systemName: systemName)
                .resizable()
                .scaledToFit()
                .frame(width: size * (isOn ? 1.2 : 1), height: size * (isOn ? 1.2 : 1))
                .foregroundColor(isOn ? .on : .off)
                .shadow(color: .shadow, radius: 4, x: 0, y: 0)
        }
        .frame(width: size * 1.2, height: size * 1.2)
    }
}

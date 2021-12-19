//
//  IconImageView.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/12/19.
//

import SwiftUI

struct IconImageView: View {
    var nameOn: String
    var nameOff: String?
    var size: CGFloat = 20
    var isOn: Bool = true
    var body: some View {
        Image(systemName: isOn ? nameOn : nameOff ?? nameOn)
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .foregroundColor(isOn ? .on : .off)
    }
}

struct IconImageView_Previews: PreviewProvider {
    static var previews: some View {
        IconImageView(nameOn: "clock")
    }
}

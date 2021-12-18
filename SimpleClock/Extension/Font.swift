//
//  Font.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/04/14.
//

import SwiftUI

extension Font {
    static func mainFont(size: CGFloat) -> Font {
        return Font.custom("Play-Regular", size: size)
    }
}

extension UIFont {
    static func mainFont(size: CGFloat) -> UIFont {
        return UIFont(name: "Play-Regular", size: size)!
    }
}

//
//  ActivityGridView.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/12/19.
//

import SwiftUI

struct ActivityGridView: View {
    // (i, j)
    // (0, 0) (1, 0)
    // (0, 1) (1, 1)
    @Binding var activity: Activity
    var xCount: Int = 20
    var showDate: Bool = true
    var defaultWidth: CGFloat = 400
    private var gridWidth: CGFloat {
        min(UIScreen.main.bounds.width, UIScreen.main.bounds.height, defaultWidth) - 40
    }
    private var gridSize: CGFloat {
        gridWidth / CGFloat(xCount) - spacing
    }
    private let spacing: CGFloat = 2
    private func leftTopDate() -> Date {
        let sundayComp = Calendar.current.dateComponents([.weekOfYear, .yearForWeekOfYear], from: Date())
        let sunday = Calendar.current.date(from: sundayComp)!
        return sunday.addingTimeInterval(TimeInterval(-7 * (xCount - 1) * 24 * 3600))
    }

    var body: some View {
        var seconds = [[Int]](repeating: [Int](repeating: 0, count: 7), count: xCount)
        for history in activity.histories {
            if let (x, y) = dateToIndex(date: history.startDate) {
                seconds[x][y] += history.second
            }
        }
        return VStack {
            HStack(spacing: spacing) {
                ForEach(0 ..< xCount) { i in
                    VStack(spacing: spacing) {
                        ForEach(0 ..< 7) { j in
                            if isOverToday(x: i, y: j) {
                                Color.clear
                                    .frame(width: gridSize, height: gridSize)
                            }
                            else {
                                secondToColor(second: seconds[i][j])
                                    .frame(width: gridSize, height: gridSize)
                            }
                        }
                    }
                }
            }
            
            if showDate {
                HStack {
                    ForEach(0 ..< 4) { i in
                        Text(leftTopDate().addingTimeInterval(
                            TimeInterval((i * xCount / 4 + xCount / 4 / 2) * 3600 * 24 * 7)
                        ).formatDate(format: "MM/dd"))
                            .foregroundColor(.text)
                            .font(.mainFont(size: 10))
                            .frame(maxWidth: .infinity)
                    }
                }
                .frame(maxWidth: min(.infinity, gridWidth))
                .padding(10)
            }
        }
    }
    
    private func isOverToday(x: Int, y: Int) -> Bool {
        guard let (today_x, today_y) = dateToIndex(date: Date()) else {
            print("Error converting Date() to index")
            return false
        }
        if x < today_x { return false }
        if y <= today_y { return false }
        return true
    }
    
    private func dateToIndex(date: Date) -> (Int, Int)? {
        let index = Int(leftTopDate().distance(to: date) / (3600 * 24))
        if index < 0 {
            return nil
        }
        return (index / 7, index % 7)
    }
    
    private func secondToColor(second: Int) -> Color {
        if second == 0 {
            return .light
        }
        return .orange.opacity(max(0.2, min(1, (Double(second) / 3600))))
    }
}

struct ActivityGridView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityGridView(activity: Binding.constant(Activity()))
    }
}

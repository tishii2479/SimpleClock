//
//  ActivityHistoryChartView.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/12/18.
//

import SwiftUI
import Charts

// Workaround for unnesseary update
// FIXME: investigate the update and remove.
private var historyCount: Int? = nil

struct ActivityHistoryChartView: UIViewRepresentable {
    @Binding var activity: Activity

    func makeUIView(context: Context) -> LineChartView {
        let chartView = LineChartView()
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.drawAxisLineEnabled = false
        chartView.xAxis.drawGridLinesEnabled = true
        chartView.xAxis.granularity = 1
        chartView.xAxis.labelTextColor = UIColor(.text)
        chartView.xAxis.setLabelCount(4, force: true)
        chartView.xAxis.labelRotationAngle = -60
        
        chartView.leftAxis.axisMinimum = 0
        chartView.leftAxis.granularity = 1
        chartView.leftAxis.drawAxisLineEnabled = false
        chartView.leftAxis.labelTextColor = UIColor(.text)
        chartView.leftAxis.setLabelCount(4, force: true)
        chartView.leftAxis.labelFont = UIFont.mainFont(size: 10)
        chartView.rightAxis.enabled = false
        
        chartView.highlightPerTapEnabled = false
        chartView.highlightPerDragEnabled = false
        chartView.doubleTapToZoomEnabled = false
        chartView.pinchZoomEnabled = false
        chartView.legend.enabled = false
        chartView.noDataText = "データがありません"
        chartView.noDataTextColor = UIColor(.text)
        
        historyCount = nil

        return chartView
    }

    func updateUIView(_ uiView: LineChartView, context: Context) {
        var dataEntries = [ChartDataEntry]()
        var accumulateTime: Double = 0
        let histories = activity.histories
        
        if histories.count == 0 {
            uiView.data = nil
            uiView.animate(xAxisDuration: 0)
            return
        }
        
        if let historyCount = historyCount, histories.count == historyCount {
            return
        }

        for history in histories {
            accumulateTime += Double(history.second)
            dataEntries.append(
                ChartDataEntry(
                    x: Double(Calendar.current.dateComponents([.second], from: histories[0].startDate, to: history.endDate).second!),
                    y: accumulateTime
                )
            )
        }
        // Add point for current time
        dataEntries.append(
            ChartDataEntry(
                x: Double(Calendar.current.dateComponents([.second], from: histories[0].startDate, to: Date()).second!),
                y: accumulateTime
            )
        )

        let dataSet = LineChartDataSet(entries: dataEntries)
        dataSet.lineWidth = 3.0
        dataSet.drawCirclesEnabled = false
        dataSet.drawValuesEnabled = false
        dataSet.setColor(UIColor(.border))
        dataSet.mode = .linear
        let gradientColors = [UIColor(Color.orange).cgColor, UIColor(Color.highBlue).withAlphaComponent(0.5).cgColor] as CFArray
        let colorLocations: [CGFloat] = [0.5, 0.0]
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations)
        dataSet.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0)
        dataSet.fillAlpha = 0.8
        dataSet.drawFilledEnabled = true
        
        uiView.data = LineChartData(dataSet: dataSet)
        uiView.leftAxis.axisMaximum = accumulateTime * 1.3
        uiView.xAxis.valueFormatter = ChartXAxisFormatter(startDate: histories[0].startDate)
        uiView.leftAxis.valueFormatter = ChartLeftAxisFormatter(maxValue: accumulateTime)
        uiView.animate(xAxisDuration: 0)
        
        historyCount = histories.count
    }
    
    class ChartLeftAxisFormatter: NSObject, IAxisValueFormatter {
        var maxValue: Double
        
        init (maxValue: Double) {
            self.maxValue = maxValue
        }

        public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
            if maxValue < 120 {
                let second = Int(value)
                return String(format: "%ds", second)
            }
            else if maxValue < 7200 {
                let minute = Int(value / 60)
                return String(format: "%dm", minute)
            }
            else {
                let hour = Int(value / 3600)
                return String(format: "%dh", hour)
            }
        }
    }
    
    class ChartXAxisFormatter: NSObject, IAxisValueFormatter {
        let dateFormatter = DateFormatter()
        var startDate: Date
         
        init(startDate: Date) {
            self.startDate = startDate
        }
     
        public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
            let modifiedDate = Calendar.current.date(byAdding: .second, value: Int(value), to: startDate)!
            dateFormatter.dateFormat = "M/d"
            return dateFormatter.string(from: modifiedDate)
        }
    }
}

struct ActivityHistoryChartView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityHistoryChartView(activity: Binding.constant(Activity()))
    }
}

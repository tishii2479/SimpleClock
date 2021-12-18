//
//  HistoryChartView.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/12/18.
//

import SwiftUI
import Charts

struct HistoryChartView: UIViewRepresentable {
    func makeUIView(context: Context) -> LineChartView {
        let chartView = LineChartView()
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.drawAxisLineEnabled = false
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.granularity = 1
        chartView.xAxis.labelTextColor = UIColor(.text)
        
        chartView.leftAxis.axisMinimum = 0
        chartView.leftAxis.granularity = 1
        chartView.leftAxis.drawAxisLineEnabled = false
        chartView.leftAxis.labelTextColor = UIColor(.text)
        chartView.rightAxis.enabled = false
        
        chartView.highlightPerTapEnabled = false
        chartView.highlightPerDragEnabled = false
        chartView.doubleTapToZoomEnabled = false
        chartView.pinchZoomEnabled = false
        chartView.legend.enabled = false
        chartView.noDataText = "データがありません"
        chartView.noDataTextColor = UIColor(.text)

        return chartView
    }

    func updateUIView(_ uiView: LineChartView, context: Context) {
        var dataEntries = [ChartDataEntry]()
        var accumulateTime: Double = 0
        let histories: [ActivityHistory] = Array(Activity.current.histories)
        
        if histories.count == 0 {
            uiView.data = nil
            uiView.animate(xAxisDuration: 0)
            return
        }
        
        for history in histories {
            accumulateTime += Double(history.time)
            let chartDataEntry = ChartDataEntry(x: Double(Calendar.current.dateComponents([.second], from: histories[0].startDate, to: history.startDate).second!), y: accumulateTime)
            dataEntries.append(chartDataEntry)
        }

        let dataSet = LineChartDataSet(entries: dataEntries)
        dataSet.lineWidth = 3.0
        dataSet.circleRadius = 6.0
        dataSet.valueTextColor = UIColor(.border)
        dataSet.setCircleColor(UIColor(.border))
        dataSet.setColor(UIColor(.border))
        dataSet.circleHoleColor = UIColor(.border)
        dataSet.mode = .linear
        
        uiView.data = LineChartData(dataSet: dataSet)
        uiView.xAxis.valueFormatter = ChartXAxisFormatter(startDate: histories[0].startDate)
        uiView.xAxis.setLabelCount(7, force: true)
        uiView.animate(xAxisDuration: 0)
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

struct HistoryChartView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryChartView()
    }
}

//
//  ViewController.swift
//  BarCharExample
//
//  Created by Amit kumar Swami on 04/02/16.
//  Copyright © 2016 Aks. All rights reserved.
//

import UIKit
import Darwin

class ViewController: UIViewController, ChartViewDelegate {

    @IBOutlet weak var barChartView: BarChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        chartViewSetUp()
        barChartData()
    }

    private func chartViewSetUp() {
        barChartView.delegate = self

        barChartView.descriptionText = ""
        barChartView.noDataTextDescription = "You need to provide data for the chart."
        
        barChartView.drawBarShadowEnabled = false
        barChartView.drawValueAboveBarEnabled = false
        
        barChartView.maxVisibleValueCount = 10
        barChartView.pinchZoomEnabled = false
        barChartView.doubleTapToZoomEnabled = false
        barChartView.drawGridBackgroundEnabled = true
        
        barChartView.scaleYEnabled = false
        barChartView.setVisibleXRangeMaximum(0.18)
        
        barChartView.rightAxis.enabled = false
        
        let xAxis: ChartXAxis = barChartView.xAxis
        xAxis.labelPosition = ChartXAxis.XAxisLabelPosition.Bottom
        xAxis.labelFont = UIFont.systemFontOfSize(10)
        xAxis.labelTextColor = UIColor.whiteColor()
        xAxis.drawGridLinesEnabled = false
        xAxis.drawAxisLineEnabled = true
        xAxis.drawLabelsEnabled = true
        
        let leftAxis: ChartYAxis = barChartView.leftAxis
        leftAxis.labelFont = UIFont.systemFontOfSize(10)
        leftAxis.labelCount = 8
        leftAxis.labelTextColor = UIColor.whiteColor()
        leftAxis.valueFormatter = NSNumberFormatter()
        leftAxis.valueFormatter?.maximumFractionDigits = 0;
        leftAxis.valueFormatter?.negativeSuffix = " hr"
        leftAxis.valueFormatter?.positiveSuffix = " hr"
        leftAxis.labelPosition = ChartYAxis.YAxisLabelPosition.OutsideChart
        leftAxis.spaceTop = 0.15
        leftAxis.drawLabelsEnabled = true
        leftAxis.drawAxisLineEnabled = false
        leftAxis.drawLimitLinesBehindDataEnabled = true
        leftAxis.gridLineDashLengths = [2.0]
        barChartView.leftYAxisRenderer = YAxisRenderer(viewPortHandler: barChartView.viewPortHandler, yAxis: leftAxis, transformer: barChartView._leftAxisTransformer)
        
        barChartView.legend.position = ChartLegend.ChartLegendPosition.AboveChartCenter
        barChartView.legend.form = ChartLegend.ChartLegendForm.Square
        barChartView.legend.formSize = 9.0
        barChartView.legend.font = UIFont.systemFontOfSize(11)
        barChartView.legend.xEntrySpace = 2.0

        barChartView.backgroundColor = UIColor(red: 0.161, green: 0.161, blue: 0.161, alpha: 1.00)
        barChartView.gridBackgroundColor = UIColor(red: 0.161, green: 0.161, blue: 0.161, alpha: 1.00)
        barChartView.highlightPerTapEnabled = true
        barChartView.moveViewToX(100)
        barChartView.drawMarkers = true
        let chartMarker = BarChartMarker.init(color: UIColor.whiteColor(), insets: UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0))
        chartMarker.minimumSize = CGSize(width: 80.0, height: 60.0)
        barChartView.marker = chartMarker
        barChartView.animate(xAxisDuration: 3.0, yAxisDuration: 3.0)
    }
    
    private func barChartData() {
        var xVals = [String]()
        
        var yVals = [BarChartDataEntry]()
        for i in 1...30 {
            let val = Double(arc4random_uniform(10))
            let entry = BarChartDataEntry(values: [val, val+10], xIndex: i)
            let timeSheet = Timesheet()
            timeSheet.numberOfHours = val
            timeSheet.startTime = NSDate()
            timeSheet.endTime = NSDate()
            timeSheet.time = NSDate()
            timeSheet.place = "Delhi"
            entry.data = timeSheet
            yVals.append(entry)
            xVals.append("\(i)")
        }
        let dataSet: BarChartDataSet = BarChartDataSet(yVals: yVals, label: "DataSet")
        dataSet.highlightEnabled = false
        //dataSet.colors = [UIColor(red: 0.812, green: 0.200, blue: 0.086, alpha: 1.00), UIColor(red: 0.494, green: 0.133, blue: 0.067, alpha: 1.00)]
        dataSet.colors = [UIColor.orangeColor(), UIColor(red: 0.992, green: 0.812, blue: 0.565, alpha: 1.00)]
        dataSet.valueTextColor = UIColor.whiteColor()
        dataSet.barSpace = 0.5
        barChartView.data = BarChartData(xVals: xVals, dataSet: dataSet)
    }
}




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
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func chartViewSetUp() {
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
        barChartView.setVisibleXRangeMaximum(0.25)
        barChartView.setVisibleXRange(minXRange: 0.25, maxXRange: 0.50)
        barChartView.rightAxis.enabled = false
        
        let xAxis: ChartXAxis = barChartView.xAxis
        xAxis.labelPosition = ChartXAxis.XAxisLabelPosition.Bottom
        xAxis.labelFont = UIFont.systemFontOfSize(10)
        xAxis.labelTextColor = UIColor.blackColor()
        xAxis.drawGridLinesEnabled = false
        xAxis.drawAxisLineEnabled = true
        xAxis.drawLabelsEnabled = true
        
        
        let leftAxis: ChartYAxis = barChartView.leftAxis
        leftAxis.labelFont = UIFont.systemFontOfSize(10)
        leftAxis.labelCount = 8
        leftAxis.valueFormatter = NSNumberFormatter()
        leftAxis.valueFormatter?.maximumFractionDigits = 0;
        leftAxis.valueFormatter?.negativeSuffix = " hr"
        leftAxis.valueFormatter?.positiveSuffix = " hr"
        leftAxis.labelPosition = ChartYAxis.YAxisLabelPosition.OutsideChart
        leftAxis.spaceTop = 0.15
        leftAxis.drawLabelsEnabled = true
        leftAxis.drawLimitLinesBehindDataEnabled = true
        leftAxis.gridLineDashLengths = [2.0]
        barChartView.leftYAxisRenderer = YAxisRenderer(viewPortHandler: barChartView.viewPortHandler, yAxis: leftAxis, transformer: barChartView._leftAxisTransformer)
        
        barChartView.legend.position = ChartLegend.ChartLegendPosition.AboveChartCenter
        barChartView.legend.form = ChartLegend.ChartLegendForm.Square
        barChartView.legend.formSize = 9.0
        barChartView.legend.font = UIFont.systemFontOfSize(11)
        barChartView.legend.xEntrySpace = 2.0
        barChartView.drawValueAboveBarEnabled = true
        
    }
    
    func barChartData() {
        var xVals = [String]()
        
        var yVals = [BarChartDataEntry]()
        for i in 1...30 {
            let val = Double(arc4random_uniform(10))
            yVals.append(BarChartDataEntry(values: [val, val+10], xIndex: i))
            xVals.append("\(i)")
        }
        let dataSet: BarChartDataSet = BarChartDataSet(yVals: yVals, label: "DataSet")
        dataSet.colors = [UIColor.orangeColor(), ChartColorTemplates.vordiplom()[2]]

        barChartView.data = BarChartData(xVals: xVals, dataSet: dataSet)
    }

    
}


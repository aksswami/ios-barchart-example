//
//  ViewController.swift
//  BarCharExample
//
//  Created by Amit kumar Swami on 04/02/16.
//  Copyright © 2016 Aks. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ChartViewDelegate {

    @IBOutlet weak var barChartView: BarChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        chartViewSetUp()
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
        barChartView.drawValueAboveBarEnabled = true
        
        barChartView.maxVisibleValueCount = 100
        barChartView.pinchZoomEnabled = false
        barChartView.drawGridBackgroundEnabled = false
        
        let xAxis: ChartXAxis = barChartView.xAxis
        xAxis.labelPosition = ChartXAxis.XAxisLabelPosition.Bottom
        xAxis.labelFont = UIFont.systemFontOfSize(10)
        xAxis.drawGridLinesEnabled = false
        xAxis.spaceBetweenLabels = 2
        
        
        let leftAxis: ChartYAxis = barChartView.leftAxis
        leftAxis.labelFont = UIFont.systemFontOfSize(10)
        leftAxis.labelCount = 8
        leftAxis.valueFormatter = NSNumberFormatter()
        leftAxis.valueFormatter?.maximumFractionDigits = 0;
        leftAxis.valueFormatter?.negativeSuffix = " hr"
        leftAxis.valueFormatter?.positiveSuffix = " hr"
        leftAxis.labelPosition = ChartYAxis.YAxisLabelPosition.OutsideChart
        leftAxis.spaceTop = 0.15
        
        barChartView.legend.position = ChartLegend.ChartLegendPosition.AboveChartCenter
        barChartView.legend.form = ChartLegend.ChartLegendForm.Square
        barChartView.legend.formSize = 9.0
        barChartView.legend.font = UIFont.systemFontOfSize(11)
        barChartView.legend.xEntrySpace = 4.0
    }
    

}


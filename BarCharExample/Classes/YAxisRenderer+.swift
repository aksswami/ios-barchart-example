//
//  YAxisRenderer+.swift
//  BarCharExample
//
//  Created by Amit kumar Swami on 05/02/16.
//  Copyright © 2016 Aks. All rights reserved.
//

import Foundation
import UIKit

class YAxisRenderer: ChartYAxisRenderer {
    private var _gridLineBuffer1 = [CGPoint](count: 2, repeatedValue: CGPoint())
    internal override func renderGridLines(context context: CGContext)
    {
        if (!_yAxis.isDrawGridLinesEnabled || !_yAxis.isEnabled)
        {
            return
        }
        
        CGContextSaveGState(context)
        
        CGContextSetStrokeColorWithColor(context, _yAxis.gridColor.CGColor)
        CGContextSetLineWidth(context, _yAxis.gridLineWidth)
        if (_yAxis.gridLineDashLengths != nil)
        {
            CGContextSetLineDash(context, _yAxis.gridLineDashPhase, _yAxis.gridLineDashLengths, _yAxis.gridLineDashLengths.count)
        }
        else
        {
            CGContextSetLineDash(context, 0.0, nil, 0)
        }
        
        let valueToPixelMatrix = transformer.valueToPixelMatrix
        
        var position = CGPoint(x: 0.0, y: 0.0)
        
        // draw the horizontal grid
        CGContextSetLineDash(context, 0.0, nil, 0)
        for (var i = 1, count = _yAxis.entryCount; i < count; i++)
        {
            position.x = 0.0
            position.y = CGFloat(_yAxis.entries[i])
            position = CGPointApplyAffineTransform(position, valueToPixelMatrix)
            
            _gridLineBuffer1[0].x = viewPortHandler.contentLeft
            _gridLineBuffer1[0].y = position.y
            _gridLineBuffer1[1].x = viewPortHandler.contentRight
            _gridLineBuffer1[1].y = position.y
            CGContextStrokeLineSegments(context, _gridLineBuffer1, 2)
        }
        var position1 = CGPoint(x: 0.0, y: 0.0)
        CGContextSetLineDash(context, _yAxis.gridLineDashPhase, _yAxis.gridLineDashLengths, _yAxis.gridLineDashLengths.count)
        for (var i = 1, count = _yAxis.entryCount; i < count; i++)
        {
            
            let previousY = CGFloat(_yAxis.entries[i-1])
            let currentY = CGFloat(_yAxis.entries[i])
            
            position.y = previousY + (currentY - previousY) / 3
            position.x = 0.0
            
            position = CGPointApplyAffineTransform(position, valueToPixelMatrix)
            
            _gridLineBuffer1[0].x = viewPortHandler.contentLeft
            _gridLineBuffer1[0].y = position.y
            _gridLineBuffer1[1].x = viewPortHandler.contentRight
            _gridLineBuffer1[1].y = position.y
            CGContextStrokeLineSegments(context, _gridLineBuffer1, 2)
            
            position1.y = previousY + (2 * (currentY - previousY) / 3)
            position1.x = 0.0
            
            position1 = CGPointApplyAffineTransform(position1, valueToPixelMatrix)
            
            _gridLineBuffer1[0].x = viewPortHandler.contentLeft
            _gridLineBuffer1[0].y = position1.y
            _gridLineBuffer1[1].x = viewPortHandler.contentRight
            _gridLineBuffer1[1].y = position1.y
            CGContextStrokeLineSegments(context, _gridLineBuffer1, 2)
        }
        
        
        
        CGContextRestoreGState(context)
    }

}
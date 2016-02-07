//
//  BarChartMarker.swift
//  BarCharExample
//
//  Created by Amit kumar Swami on 05/02/16.
//  Copyright © 2016 Aks. All rights reserved.
//

import Foundation
import UIKit

class BarChartMarker: ChartMarker {
    internal var arrowSize = CGSize(width: 10, height: 10)
    internal var insets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    internal var minimumSize = CGSize()
    internal var color = UIColor.clearColor()
    internal var arrowYOffset:CGFloat = 0
    internal var bubbleCornerRadius: CGFloat = 4
    
    private var _labelSize: CGSize = CGSize()
    private var _size: CGSize = CGSize()
    private var _paragraphStyle: NSMutableParagraphStyle?
    private var attributedStr: NSMutableAttributedString?
    
    internal init(color: UIColor, insets: UIEdgeInsets) {
        super.init()
        
        self.insets = insets
        self.color = color
        
        _paragraphStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as? NSMutableParagraphStyle
        _paragraphStyle?.alignment = .Center
    }
    
    internal override var size: CGSize { return _size; }
    
    internal override func draw(context context: CGContext?, point: CGPoint) {
        _size.width = _size.width + arrowSize.width
        arrowYOffset = _size.height * 0.5 - arrowSize.height * 0.5
        var rightArrow = false
        if point.x > (UIScreen.mainScreen().bounds.size.width * 0.5) {
            rightArrow = true
        }
        
        var rect = CGRect(origin: point, size: _size)
        rect.origin.y -= (_size.height * 0.5)
        
        CGContextSaveGState(context)
        CGContextSetShadowWithColor(context, CGSizeMake(0, 0), 4, UIColor.orangeColor().colorWithAlphaComponent(0.25).CGColor);
        CGContextSetLineWidth(context, 1.0);
        CGContextSetStrokeColorWithColor(context, UIColor.grayColor().CGColor)
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextBeginPath(context)
        
        if !rightArrow {
            CGContextMoveToPoint(context,
                rect.origin.x + arrowSize.width + bubbleCornerRadius,
                rect.origin.y)
            CGContextAddLineToPoint(context,
                rect.origin.x + rect.size.width - bubbleCornerRadius,
                rect.origin.y)
            // Top Right Corner
            CGContextAddArcToPoint(context, rect.origin.x + rect.size.width, rect.origin.y, rect.origin.x + rect.size.width, rect.origin.y + bubbleCornerRadius, bubbleCornerRadius)
            
            CGContextAddLineToPoint(context,
                rect.origin.x + rect.size.width,
                rect.origin.y + rect.size.height - bubbleCornerRadius)
            // Bottom Right
            CGContextAddArcToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height, rect.origin.x + rect.size.width - bubbleCornerRadius, rect.origin.y + rect.size.height, bubbleCornerRadius)
            
            CGContextAddLineToPoint(context,
                rect.origin.x + arrowSize.width + bubbleCornerRadius,
                rect.origin.y + rect.size.height)
            // Bottom Left
            CGContextAddArcToPoint(context, rect.origin.x + arrowSize.width, rect.origin.y + rect.size.height, rect.origin.x + arrowSize.width, rect.origin.y + rect.size.height - bubbleCornerRadius, bubbleCornerRadius)
            
            
            CGContextAddLineToPoint(context,
                rect.origin.x + arrowSize.width,
                rect.origin.y + arrowYOffset + arrowSize.height
            )
            CGContextAddLineToPoint(context,
                rect.origin.x,
                rect.origin.y + arrowYOffset + arrowSize.height/2
            )
            CGContextAddLineToPoint(context,
                rect.origin.x + arrowSize.width,
                rect.origin.y + arrowYOffset
            )
            
            CGContextAddLineToPoint(context,
                rect.origin.x + arrowSize.width,
                rect.origin.y + bubbleCornerRadius)
            CGContextAddArcToPoint(context, rect.origin.x + arrowSize.width, rect.origin.y, rect.origin.x + arrowSize.width + bubbleCornerRadius, rect.origin.y, bubbleCornerRadius)
        } else {
            rect.origin.x -= size.width
            CGContextMoveToPoint(context,
                rect.origin.x,
                rect.origin.y)
            CGContextAddLineToPoint(context,
                rect.origin.x + rect.size.width - arrowSize.width - bubbleCornerRadius,
                rect.origin.y)
            CGContextAddArcToPoint(context, rect.origin.x + rect.size.width - arrowSize.width, rect.origin.y, rect.origin.x + rect.size.width - arrowSize.width, rect.origin.y + bubbleCornerRadius, bubbleCornerRadius)
            
            CGContextAddLineToPoint(context,
                rect.origin.x + rect.size.width - arrowSize.width,
                rect.origin.y + rect.size.height - arrowYOffset - arrowSize.height)
            CGContextAddLineToPoint(context,
                rect.origin.x + rect.size.width,
                rect.origin.y + rect.size.height - arrowYOffset - arrowSize.height/2)
            CGContextAddLineToPoint(context,
                rect.origin.x + rect.size.width - arrowSize.width,
                rect.origin.y + rect.size.height - arrowYOffset)
            
            CGContextAddLineToPoint(context,
                rect.origin.x + rect.size.width - arrowSize.width,
                rect.origin.y + rect.size.height - bubbleCornerRadius)
            CGContextAddArcToPoint(context, rect.origin.x + rect.size.width - arrowSize.width, rect.origin.y + rect.size.height, rect.origin.x + rect.size.width - arrowSize.width - bubbleCornerRadius, rect.origin.y + rect.size.height, bubbleCornerRadius)
            CGContextAddLineToPoint(context,
                rect.origin.x + bubbleCornerRadius,
                rect.origin.y + rect.size.height)
            CGContextAddArcToPoint(context, rect.origin.x, rect.origin.y + rect.size.height, rect.origin.x, rect.origin.y + rect.size.height - bubbleCornerRadius, bubbleCornerRadius)
            
            CGContextAddLineToPoint(context,
                rect.origin.x,
                rect.origin.y + bubbleCornerRadius)
            CGContextAddArcToPoint(context, rect.origin.x, rect.origin.y, rect.origin.x + bubbleCornerRadius, rect.origin.y, bubbleCornerRadius)
        }
        
        CGContextDrawPath(context, .FillStroke)
        CGContextRestoreGState(context);
        CGContextSaveGState(context)
        
        rect.origin.y += insets.top
        
        !rightArrow ? (rect.origin.x += insets.left) : (rect.origin.x -= insets.right)
        
        rect.size.height -= insets.top + insets.bottom
        
        UIGraphicsPushContext(context!)
        attributedStr?.drawInRect(rect)
        UIGraphicsPopContext()
        
        CGContextRestoreGState(context)
    }
    
    internal override func refreshContent(entry entry: ChartDataEntry, highlight: ChartHighlight) {
        guard let timesheet: Timesheet = entry.data as? Timesheet else {return}
        
        let dayStr = "\(timesheet.time?.stringWithFormat("EEEE - MMMM d, yyyy") ?? "")\n\n"
        
        let totalHoursStr = "\((highlight.range?.to ?? 0) - (highlight.range?.from ?? 0)) Hours\n"
        
        let timeIntervalStr = "\(timesheet.startTime?.stringWithFormat("h:mm a") ?? "") - \(timesheet.endTime?.stringWithFormat("h:mm a") ?? "")\n"
        
        let placeStr = timesheet.place! + "\n"
        
        let workingTypeStr = "Working Type: " + (highlight.stackIndex == 0 ? "ST\n" : "OT\n")
        
        let str = (dayStr + totalHoursStr + timeIntervalStr + placeStr + workingTypeStr) as NSString
        
        let dayRange = str.rangeOfString(dayStr)
        let dayAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(8), NSForegroundColorAttributeName: UIColor.lightGrayColor()]
        
        let totalHourRange = str.rangeOfString(totalHoursStr)
        let totalHourStrAttributes = [NSFontAttributeName: UIFont.boldSystemFontOfSize(12), NSForegroundColorAttributeName: UIColor.redColor()]
        
        let timeIntervalStrRange = str.rangeOfString(timeIntervalStr)
        let timeIntervalStrAttributes = [NSFontAttributeName: UIFont.boldSystemFontOfSize(10), NSForegroundColorAttributeName: UIColor.grayColor()]
        
        let placeStrRange = str.rangeOfString(placeStr)
        let placeStrAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(8), NSForegroundColorAttributeName: UIColor.lightGrayColor()]
        
        let workingTypeStrRange = str.rangeOfString(workingTypeStr)
        let workingTypeStrAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(8), NSForegroundColorAttributeName: UIColor.grayColor()]
        
        let attributeString = NSMutableAttributedString(string: str as String)
        
        attributeString.addAttributes(dayAttributes, range: dayRange)
        attributeString.addAttributes(totalHourStrAttributes, range: totalHourRange)
        attributeString.addAttributes(timeIntervalStrAttributes, range: timeIntervalStrRange)
        attributeString.addAttributes(placeStrAttributes, range: placeStrRange)
        attributeString.addAttributes(workingTypeStrAttributes, range: workingTypeStrRange)
        attributeString.addAttribute(NSParagraphStyleAttributeName, value: _paragraphStyle!, range: NSRange.init(location: 0, length: str.length))
        
        attributedStr = attributeString
        
        _labelSize = attributeString.size() ?? CGSizeZero
        _size.width = _labelSize.width + insets.left + insets.right
        _size.height = _labelSize.height + insets.top + insets.bottom
        _size.width = max(minimumSize.width, _size.width)
        _size.height = max(minimumSize.height, _size.height)
    }
}

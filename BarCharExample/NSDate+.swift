//
//  NSDate+.swift
//  BarCharExample
//
//  Created by Amit kumar Swami on 06/02/16.
//  Copyright © 2016 Aks. All rights reserved.
//

import Foundation

public extension NSDate {
    
    public func stringWithFormat(format:String? = "YYYY-MM-dd") -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = format
        
        return formatter.stringFromDate(self)
    }

}
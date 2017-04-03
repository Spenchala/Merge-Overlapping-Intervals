//
//  ConversionUtils.swift
//  ios-interview
//
//  Created by Sandeep Penchala on 2/01/17.
//  Copyright © 2017 . All rights reserved.
//

import Foundation
class ConversionUtils: NSObject {
   public static func convertSecondsToTime(seconds: Int) -> String{
        let minutes: Int = (seconds / 60) % 60
        let hours: Int = (seconds%86400) / 3600
        return String(format: "%02d:%02d", hours, minutes)
    }
}

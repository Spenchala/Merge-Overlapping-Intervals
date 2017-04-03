//
//  VistorData.swift
//  ios-interview
//
//  Created by Sandeep Penchala on 2/01/17.
//  Copyright © 2017 . All rights reserved.
//

import Foundation
class VisitorData: NSObject {
    /*
     "id": "amy",
     "name": "Amy",
     "arriveTime": 32400,
     "leaveTime": 43200
     */
    var id:String?
    var name: String?
    var arriveTime:Int?
    var leaveTime:Int?
    private var convertedArrivalTime:String=""
    private var convertedleaveTime:String=""
    var timeinHrsMinutes:String = ""
    init(id: String?, name: String?, arriveTime:Int?, leaveTime:Int?) {
        self.id = id
        self.name = name
        self.arriveTime = arriveTime
        self.leaveTime = leaveTime
        if let arriveTime = arriveTime{
        convertedArrivalTime = ConversionUtils.convertSecondsToTime(seconds: arriveTime)
            timeinHrsMinutes = "\(convertedArrivalTime)"
           
        }
        if let leaveTime = leaveTime{
             convertedleaveTime = ConversionUtils.convertSecondsToTime(seconds: leaveTime)
            timeinHrsMinutes = "\(timeinHrsMinutes) - \(convertedleaveTime)"
        }
        print("name : \(name) and time : \(timeinHrsMinutes)")
}
}

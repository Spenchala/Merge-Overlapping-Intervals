//
//  PeopleHereManager.swift
//  ios-interview
//
//  Created by Sandeep Penchala on 2/01/17.
//  Copyright © 2017 . All rights reserved.
//

import Foundation
class PeopleHereManager: NSObject {
    var peopleDetails:VenueDetails?
    
    init(withJsonPath path: String?) {
        super.init()
        var json:[String: AnyObject]?
        if let path = path {
            do{
                let detailsJson = try? String(contentsOfFile: path, encoding: String.Encoding.utf8)
                if let detailsJson = detailsJson{
                    if let data = detailsJson.data(using: String.Encoding.utf8, allowLossyConversion: true) {
                        try json =  JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? Dictionary<String, AnyObject>
                    }
                }
            }
            catch {
                print(error)
            }
        }
        
        //Parse the Json now
        if let json = json{
            if let venueDict = json[Constants.KEY_VENUE] as? Dictionary<String, AnyObject> {
                let id = venueDict[Constants.KEY_ID] as? String
                let name = venueDict[Constants.KEY_NAME] as? String
                let openTime = venueDict[Constants.KEY_OPENTIME] as? Int
                let closeTime = venueDict[Constants.KEY_CLOSETIME] as? Int
                let visitorsArray = venueDict[Constants.KEY_VISITORS] as? Array<Dictionary<String, AnyObject>>
                peopleDetails = VenueDetails(id: id, name: name, openTime: openTime, closeTime: closeTime)
                if let visitorsArray = visitorsArray{
                    peopleDetails?.visitors = [VisitorData]()
                    for visitorsDict in visitorsArray{
                        let id = visitorsDict[Constants.KEY_ID] as? String
                        let name = visitorsDict[Constants.KEY_NAME] as? String
                        let arrivalTime = visitorsDict[Constants.KEY_ARRAIVALTIME] as?Int
                        let leaveTime = visitorsDict[Constants.KEY_LEAVETIME] as? Int
                        let visitorData = VisitorData(id: id, name: name, arriveTime: arrivalTime, leaveTime: leaveTime)
                        peopleDetails?.visitors?.append(visitorData)
                    }
                    self.addNoVisitorsDatatoArray()
                }
            }
        }
    }
    //Here is my approach for this
    /* The best Sorting approach takes O(nlogn) and appending and merging with NO Visitors take O(n) and sort at the end after adding the No Visitors, so we will get the list.
     1. Sort the Array of VisitorData by ArrivalTime.
     2. Check with minimum Arrival Time and Opening Time of Merchant. add the difference from open time to arrival time with No Visitors.
     3. make initial arrival & leaveTime from 1st Visitor
     4. loop from 1 to Visitors Count.
     5. Check for the next Visitor arrivalTime of first one leaveTime if it is less then get the max of leavetime for those visitors 
     6. else at that Interval the visitor is not present. So we need to make time between them.(Delta between the Visitors(i.e Idle time)No Visitors between that duration)
     7. At last check with the closing time and with the last visitor leave time
     */
    private func addNoVisitorsDatatoArray(){
        //Sort all the Visitors by arrival time
        peopleDetails?.visitors?.sort{$0.arriveTime! < $1.arriveTime!}
        guard let count = peopleDetails?.visitors?.count  else {
            return
        }
        let firstInterval = peopleDetails?.visitors?[0]
        if let openTime = peopleDetails?.openTime,  let arrivalTime = firstInterval?.arriveTime, openTime < arrivalTime{
            let visitorData = VisitorData(id: Constants.KEY_NO_VISITORS, name: Constants.KEY_NO_VISITORS, arriveTime: openTime, leaveTime: arrivalTime)
            peopleDetails?.visitors?.append(visitorData)
        }
        var arrivalTime = firstInterval?.arriveTime;
        var leaveTime = firstInterval?.leaveTime;
        for var i in 1..<count {
            let nextInterval = peopleDetails?.visitors?[i]
            if (nextInterval?.arriveTime)! <= leaveTime!{
                leaveTime = max((nextInterval?.leaveTime)!, leaveTime!)
            } else{
                let visitorData = VisitorData(id: Constants.KEY_NO_VISITORS, name: Constants.KEY_NO_VISITORS, arriveTime: leaveTime, leaveTime: nextInterval?.arriveTime)
                peopleDetails?.visitors?.append(visitorData)
                arrivalTime = nextInterval?.arriveTime;
                leaveTime = nextInterval?.leaveTime;
            }
        }
        let lastInterval = peopleDetails?.visitors?[count - 1]
        if let closeTime = peopleDetails?.closeTime,  let leaveTime = lastInterval?.leaveTime, closeTime > leaveTime{
            let visitorData = VisitorData(id: Constants.KEY_NO_VISITORS, name: Constants.KEY_NO_VISITORS, arriveTime: leaveTime, leaveTime: closeTime)
            peopleDetails?.visitors?.append(visitorData)
        }
        peopleDetails?.visitors?.sort{$0.arriveTime! < $1.arriveTime!}
        
    }
    
}

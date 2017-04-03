//
//  VenueDetails.swift
//  ios-interview
//
//  Created by Sandeep Penchala on 2/01/17.
//  Copyright © 2017 . All rights reserved.
//

import Foundation
class VenueDetails: NSObject {
    /*
     "id": "abc123",
     "name": "Company XYZ",
     "openTime": 25200,
     "closeTime": 91800,
     */
    
    var id: String?
    var name: String?
    var openTime: Int?
    var closeTime: Int?
    var visitors:[VisitorData]?
    
    init(id: String?, name: String?, openTime: Int?,closeTime: Int?) {
        self.id = id
        self.name = name
        self.openTime = openTime
        self.closeTime = closeTime
    }
}

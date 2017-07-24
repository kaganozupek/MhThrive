//
//  Event.swift
//  My Thrive
//
//  Created by Kagan Ozupek on 7/24/17.
//  Copyright © 2017 Kagan Ozupek. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift
import Realm
class Event: Object,Mappable {
    
    dynamic var id : NSString!
    dynamic var desc : NSString!
    dynamic var end_date : NSDate!
    dynamic var event_owner : User!
    dynamic var start_date : NSDate!
    required convenience init?(map: Map) { self.init() }
    
    override static func primaryKey() -> String? {
        return "id"
    }


    
    
   

    
    func mapping(map: Map) {
        id <- map["id"]
        desc <- map["description"]
        event_owner <- map["event_owner"]
        var endDate : Double = 0
        endDate <- map["end_date"]
        var startDate : Double = 0
        startDate <- map["end_date"]
        start_date = NSDate(timeIntervalSince1970: startDate)
        end_date = NSDate(timeIntervalSince1970: endDate)
        
        
        
    }
}

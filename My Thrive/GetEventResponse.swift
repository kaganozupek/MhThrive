//
//  GetEventResponse.swift
//  My Thrive
//
//  Created by Kagan Ozupek on 7/24/17.
//  Copyright © 2017 Kagan Ozupek. All rights reserved.
//

import UIKit
import ObjectMapper

class GetEventResponse: NSObject,Mappable {
    var user : User!
    var events : [Event]!
    
    
    func mapping(map: Map) {
        
    }
    
    required init?(map: Map) {
        user <- map["user"]
        events <- map["events"]
    }

}

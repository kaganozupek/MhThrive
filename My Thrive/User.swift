//
//  User.swift
//  My Thrive
//
//  Created by Kagan Ozupek on 7/24/17.
//  Copyright © 2017 Kagan Ozupek. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift
class User: Object, Mappable {
    dynamic var user_name : NSString!
    dynamic var profile : NSString!
    
    func mapping(map: Map) {
        user_name <- map["user_name"]
        profile <- map["profile"]
    }
    
    
    required convenience init?(map: Map) { self.init() }

    
}

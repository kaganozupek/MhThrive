//
//  Validator.swift
//  My Thrive
//
//  Created by Kagan Ozupek on 7/26/17.
//  Copyright © 2017 Kagan Ozupek. All rights reserved.
//

import UIKit

class Validator: NSObject {

    static let sharedInstance : Validator = Validator()
    
    func validateEventName(text : String) -> Bool
    {
        return text.characters.count > 5 && text.characters.count < 50
    }
    
    func validateEventOwner(text : String) -> Bool
    {
        return text.characters.count > 5 && text.characters.count < 50
    }
}

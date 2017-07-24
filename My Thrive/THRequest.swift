//
//  THRequest.swift
//  My Thrive
//
//  Created by Kagan Ozupek on 7/24/17.
//  Copyright © 2017 Kagan Ozupek. All rights reserved.
//

import UIKit



@objc protocol THRequestDelegate
{
    @objc optional func success(response : AnyObject)
    @objc optional func failed(statusCode : Int, errorCode : Int)
}


class THRequest: NSObject {

   
    
    func dummyGet(url : NSString, params : [String:AnyObject], requireAuth : Bool)
    {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.testVariableDummyResponseTime) {
            
            
            
            
            
            
        }
    }
    
    
}

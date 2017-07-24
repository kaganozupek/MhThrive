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
    @objc optional func success(url : String, response : String!)
    @objc optional func failed(url : String, statusCode : Int, errorCode : Int)
}


class THRequest: NSObject {

    var delegate : THRequestDelegate!
    func dummyGet(url : String, params : [String:AnyObject]!, requireAuth : Bool)
    {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.testVariableDummyResponseTime) {
            
            if self.delegate == nil{
                return
            }
            
            
            if(Constants.testVariableHttpStatusCode == 200)
            {
                if Constants.tesetVariableErrorCode == Constants.apiErrorCodeSuccess{
                    
                    
                    let responseString : String! = Utils.sharedInstance.loadEventJson()
                    
                    if responseString != nil{
                        self.delegate.success!(url: url, response: responseString)
                    }else
                    {
                        self.delegate.failed!(url: url, statusCode: 200, errorCode: Constants.apiErrorCodeUnknown)
                    }
                }else{
                    self.delegate.failed!(url: url, statusCode: 200, errorCode: Constants.tesetVariableErrorCode)
                }
            }else
            {
                self.delegate.failed!(url: url, statusCode: 404, errorCode: Constants.apiErrorCodeUnspecified)
            }
            
        }
    }
    
    
}

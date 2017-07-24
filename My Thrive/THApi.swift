//
//  THApi.swift
//  My Thrive
//
//  Created by Kagan Ozupek on 7/24/17.
//  Copyright © 2017 Kagan Ozupek. All rights reserved.
//

import UIKit

@objc protocol BaseDelegate
{
    
}

@objc protocol GetEventDelegate : BaseDelegate
{
    @objc optional func getEventsSuccess(response : GetEventResponse)
    @objc optional func getEventFailed(errorCode : Int)
    
}


class THApi: NSObject,THRequestDelegate {
    
    var baseDelegate : BaseDelegate!
    var url : String!
    func getEvents(viewController : UIViewController,delegate : GetEventDelegate!)
    {
        self.baseDelegate = delegate
        self.url = Constants.urlGetEvents
        let request : THRequest = THRequest()
        request.delegate = self
        request.dummyGet(url: url, params: nil, requireAuth: true)
        
    }
    
    
    
    
    func success(url: String, response: String!) {
        
        if(self.url == Constants.urlGetEvents && baseDelegate is GetEventDelegate)
        {
            
            let getEventDelegate : GetEventDelegate = baseDelegate as! GetEventDelegate
            let responseObject : GetEventResponse = 
            getEventDelegate.getEventsSuccess!(response: GetEventResponse())
        }
    }
    
    func failed(url: String, statusCode: Int, errorCode: Int) {
        if(self.url == Constants.urlGetEvents && baseDelegate is GetEventDelegate)
        {
            let getEventDelegate : GetEventDelegate = baseDelegate as! GetEventDelegate
            getEventDelegate.getEventFailed!(errorCode: errorCode)
        }
    }
}

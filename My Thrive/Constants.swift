//
//  Constants.swift
//  My Thrive
//
//  Created by Kagan Ozupek on 7/23/17.
//  Copyright © 2017 Kagan Ozupek. All rights reserved.
//

import UIKit

class Constants: NSObject {
    //Dimensions
    static let dimensionHeaderViewHeight = 250;
    static let dimensionTxUpCommingCountCornerRadius : CGFloat! = 10.0;
    static let dimensionCardViewCornerRadius :CGFloat! = 10;
    static let dimensionUpcommingCountBorder : CGFloat = 2;
    
    //CellIdentifiers
    static let cellIdentifierEventCell : String = "EventCellIdentifier";
    static let cellIdentifierDateCell : String = "DateCellIdentifier";
    
    
    
    //URLS
    static let urlGetEvents : String = "/api/v3/events/"
    
    
    
    
    //Test Variables
    static let testVariableDummyResponseTime : Double  = 3
    static let testVariableHttpStatusCode : Int = 200
    static let tesetVariableErrorCode = apiErrorCodeSuccess
    
  
    //API Error Codes
    static let apiErrorCodeSuccess = 0
    static let apiErrorCodeInternalError = 1
    static let apiErrorCodeUnknown = 2
    static let apiErrorCodeUnspecified = -1
    
}

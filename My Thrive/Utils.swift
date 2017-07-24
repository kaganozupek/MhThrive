//
//  Utils.swift
//  My Thrive
//
//  Created by Kagan Ozupek on 7/24/17.
//  Copyright © 2017 Kagan Ozupek. All rights reserved.
//

import UIKit

class Utils: NSObject {
    
    
    static let sharedInstance = Utils()
    
    func loadEventJson() -> String!
    {
        do{
            let filePath : String = Bundle.main.path(forResource: "", ofType: "json")!
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
            return String(data: data, encoding: .utf8)!
        }catch
        {
            print(error.localizedDescription)
        }
        
        return nil
    }
}



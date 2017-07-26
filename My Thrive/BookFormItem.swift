//
//  BookFormItem.swift
//  My Thrive
//
//  Created by Kagan Ozupek on 7/26/17.
//  Copyright © 2017 Kagan Ozupek. All rights reserved.
//

import UIKit

class BookFormItem: UIView {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var lblWarning: UILabel!
    
    var hint : String!
    var enabled : Bool!
    var warning : String!
    
    
    override func awakeFromNib() {
        
    }
    
    
    func setup(hint : String,enabled : Bool,warning : String)
    {
        self.hint = hint
        self.enabled = enabled
        self.warning = warning
        self.textField.placeholder = self.hint
        self.textField.isEnabled = self.enabled
        self.lblWarning.text = self.warning
        
    }

    func showWarning()
    {
        self.lblWarning.isHidden = false
        
    }
    
    func reset()
    {
        self.resetWarning()
        self.textField.text = ""
    }
    
    
    func resetWarning()
    {
        self.lblWarning.isHidden = true
       
    }
}

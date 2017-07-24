//
//  THTableHeaderView.swift
//  My Thrive
//
//  Created by Kagan Ozupek on 7/23/17.
//  Copyright © 2017 Kagan Ozupek. All rights reserved.
//

import UIKit

class THTableHeaderView: UIView {

    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUpcommingCount: UILabel!
    
   
    func setUpcommingCount(count : Int)
    {
        if(count == 0){
            lblUpcommingCount.textColor = Colors.upcomming_count_zero
            lblUpcommingCount.backgroundColor = UIColor.clear
            lblUpcommingCount.layer.borderWidth = Constants.dimensionUpcommingCountBorder
            lblUpcommingCount.layer.borderColor = Colors.upcomming_count_border.cgColor
        }else{
            lblUpcommingCount.textColor = UIColor.white
            lblUpcommingCount.backgroundColor = Colors.upcomming_count_background_nonzero
            lblUpcommingCount.layer.borderWidth = 0
            lblUpcommingCount.layer.borderColor = UIColor.clear.cgColor
        }
        
        lblUpcommingCount.text = "\(count)"
    }
    
    
   
}

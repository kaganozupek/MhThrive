//
//  THEventCellTableViewCell.swift
//  My Thrive
//
//  Created by Kagan Ozupek on 7/23/17.
//  Copyright © 2017 Kagan Ozupek. All rights reserved.
//

import UIKit

class THEventCellTableViewCell: UITableViewCell {

   
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var lblEventOwner: UILabel!
    @IBOutlet weak var imgClock: UIImageView!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var imgEventOwner: UIImageView!
    @IBOutlet weak var viewBackground: UIView!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewBackground.layer.cornerRadius = Constants.dimensionCardViewCornerRadius
        viewBackground.layer.shadowColor = UIColor.gray.cgColor
        viewBackground.layer.shadowOpacity = 0.2
        viewBackground.layer.shadowOffset = CGSize.zero
        viewBackground.layer.shadowRadius = 3
        
        /*UIImage *img =  [[UIImage imageNamed:@"ic_settings"]
         imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];*/
        
        let img : UIImage = UIImage.init(named: "ic_access_time")!;
        let tintedImage = img.withRenderingMode(.alwaysTemplate)
        imgClock.image = tintedImage
        imgClock.tintColor = Colors.event_item_time
        imgEventOwner.clipsToBounds = true
        imgEventOwner.contentMode = .scaleAspectFill
        imgEventOwner.layer.cornerRadius = imgEventOwner.frame.size.height/2
    
    }

    
}

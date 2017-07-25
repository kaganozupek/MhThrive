//
//  EventTableSource.swift
//  My Thrive
//
//  Created by Kagan Ozupek on 7/23/17.
//  Copyright © 2017 Kagan Ozupek. All rights reserved.
//

import UIKit
import SDWebImage

class EventTableSource: NSObject,UITableViewDelegate,UITableViewDataSource {
    
    enum CellType {
        case EVENT
        case DATE
    }
    
    
    var datasource : [Any]!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        if(getCellType(index: indexPath) == CellType.EVENT)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifierEventCell) as! THEventCellTableViewCell
            cell.backgroundColor = UIColor.clear
            cell.selectionStyle = .none

            let event : Event = datasource[indexPath.row] as! Event
            cell.lblEventName.text = event.desc as String
            cell.lblEventOwner.text = String("with \(event.event_owner.user_name!)")
            cell.lblTime.text = Utils.sharedInstance.getEventTimeIntervalText(event: event)
            cell.imgEventOwner.sd_setImage(with: URL(string: event.event_owner.profile as String))
            return cell

            
        }else
        {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifierDateCell) as! THDateCell
            cell.backgroundColor = UIColor.clear
            cell.selectionStyle = .none
            
            
            let date : Date = datasource[indexPath.row] as! Date
            cell.lblDate.text = Utils.sharedInstance.convertDateToLocalizedText(date: date)
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func getCellType(index : IndexPath) -> CellType
    {
        let data = self.datasource[index.row]
        if data is Date{
            return CellType.DATE
        }
        else{
            return CellType.EVENT
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(getCellType(index: indexPath) == CellType.EVENT){
            return 150
        }else{
            return 50
        }
    }
    
    
    
    
    
    
}

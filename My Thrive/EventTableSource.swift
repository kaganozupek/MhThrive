//
//  EventTableSource.swift
//  My Thrive
//
//  Created by Kagan Ozupek on 7/23/17.
//  Copyright © 2017 Kagan Ozupek. All rights reserved.
//

import UIKit
import SDWebImage

@objc protocol EventTableSourceDelagate
{
    @objc func onBookNowClicked()

}


class EventTableSource: NSObject,UITableViewDelegate,UITableViewDataSource {
    
    enum CellType {
        case EVENT
        case DATE
        case EMPTY
    }
    
    
    var delegate : EventTableSourceDelagate!
    var datasource : [Any]!
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        if(getCellType(index: indexPath) == CellType.EVENT)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifierEventCell) as! THEventCellTableViewCell
            cell.backgroundColor = UIColor.clear
            cell.selectionStyle = .none

            let event : Event = datasource[indexPath.row] as! Event
            cell.lblEventName.text = event.desc as String
            if(event.event_owner != nil && event.event_owner.user_name != nil){
                cell.lblEventOwner.text = String("with \(event.event_owner.user_name!)")
                cell.lblEventOwner.isHidden = false
            }else
            {
                cell.lblEventOwner.isHidden = true
            }
            cell.lblTime.text = Utils.sharedInstance.getEventTimeIntervalText(event: event)
            if(event.event_owner != nil && event.event_owner.profile != nil){
                cell.imgEventOwner.sd_setImage(with: URL(string: event.event_owner.profile as String))
            }
            return cell

            
        }else if(getCellType(index: indexPath) == CellType.DATE)
        {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifierDateCell) as! THDateCell
            cell.backgroundColor = UIColor.clear
            cell.selectionStyle = .none
            
            
            let date : Date = datasource[indexPath.row] as! Date
            cell.lblDate.text = Utils.sharedInstance.convertDateToLocalizedText(date: date)
            return cell
        }else
        {
             let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifierEmptyCell) as! THEventEmptyCell
             cell.btnBook.layer.cornerRadius = Constants.dimentsionBookNowEmptyCellButtonCornerRadius
             cell.btnBook.clipsToBounds = true
             cell.backgroundColor = UIColor.clear
             cell.selectionStyle = .none
            cell.btnBook.addTarget(self, action: #selector(self.CLBookNow), for: .touchUpInside)
             return cell
        
        }
        
        
    }
    
    func CLBookNow()
    {
        if delegate != nil{
            delegate.onBookNowClicked()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(datasource.count > 0){
            return datasource.count
        }
        else
        {
            return 1
        }
    }
    
    func getCellType(index : IndexPath) -> CellType
    {
        if(datasource.count == 0){
            return CellType.EMPTY
        }
        
        
        let data = self.datasource[index.row]
        if data is Date{
            return CellType.DATE
        }
        else {
            return CellType.EVENT
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(getCellType(index: indexPath) == CellType.EVENT){
            return 150
        }else if getCellType(index: indexPath) == CellType.DATE{
            return 50
        }else
        {
            return 200
        
        }
    }
    
    
    
    
    
    
}

//
//  EventTableSource.swift
//  My Thrive
//
//  Created by Kagan Ozupek on 7/23/17.
//  Copyright © 2017 Kagan Ozupek. All rights reserved.
//

import UIKit

class EventTableSource: NSObject,UITableViewDelegate,UITableViewDataSource {
    
    enum CellType {
        case EVENT
        case DATE
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell;
        if(getCellType(index: indexPath) == CellType.EVENT)
        {
            
            cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifierEventCell) as! THEventCellTableViewCell
            cell.backgroundColor = UIColor.clear
            
        }else
        {
            cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifierDateCell) as! THDateCell
            cell.backgroundColor = UIColor.clear
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func getCellType(index : IndexPath) -> CellType
    {
        if index.row % 4 == 0{
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

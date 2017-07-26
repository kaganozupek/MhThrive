//
//  InterfaceController.swift
//  My Thrive Watch Extension
//
//  Created by Kagan Ozupek on 7/25/17.
//  Copyright © 2017 Kagan Ozupek. All rights reserved.
//

import WatchKit
import Foundation
import RealmSwift

class InterfaceController: WKInterfaceController ,GetEventDelegate {

    @IBOutlet var tblEvents: WKInterfaceTable!
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        loadEvents()
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func loadEvents()
    {
        let api : THApi = THApi()
        api.getEvents(viewController: self, delegate: self)
        
    }
    
    func setupTable(events : [Event]) {
       
        
        tblEvents.setNumberOfRows(events.count, withRowType: "EventCellIdentifier")
        
        for i in 0  ..< events.count  {
            if let row = tblEvents.rowController(at: i) as? THWatchEventCell {
                row.lblEventName.setText(events[i].desc as String!)
                row.lblEventOwner.setText(events[i].event_owner.user_name as String!)
                
               
            }
        }
    }
    
    func getEventFailed(errorCode: Int) {
        
    }
    
    func getEventsSuccess(response: GetEventResponse) {
        setupTable(events : response.events)
        
    }

}

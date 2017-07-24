//
//  MainController.swift
//  My Thrive
//
//  Created by Kagan Ozupek on 7/23/17.
//  Copyright © 2017 Kagan Ozupek. All rights reserved.
//

import UIKit
import RealmSwift

class MainController: BaseViewController,GetEventDelegate {
    
    @IBOutlet weak var tblEvents: UITableView!
    
    var tableHeaderView : THTableHeaderView!;
    var eventSource : EventTableSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initViews()
        self.loadEvents()
       
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func initViews(){
        initTableHeaderView()
        let nibEventCell = UINib(nibName: "THEventCellTableViewCell", bundle: nil)
        tblEvents.register(nibEventCell, forCellReuseIdentifier: Constants.cellIdentifierEventCell)
        let nibDateCell = UINib(nibName: "THDateCell", bundle: nil)
        tblEvents.register(nibDateCell, forCellReuseIdentifier: Constants.cellIdentifierDateCell)
        tblEvents.separatorStyle = .none
    }
    
    func initTableHeaderView(){
        let headerRect : CGRect = CGRect(x: 0, y: 0, width: Int(tblEvents.frame.size.width), height: Constants.dimensionHeaderViewHeight)
        tableHeaderView = UINib(nibName: "THTableHeaderView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! THTableHeaderView
        tableHeaderView.frame = headerRect
        tblEvents.tableHeaderView = tableHeaderView
        tableHeaderView.lblUpcommingCount.layer.cornerRadius = Constants.dimensionTxUpCommingCountCornerRadius
        tableHeaderView.lblUpcommingCount.clipsToBounds = true
    }
    
    
    func loadEvents()
    {
        setPageState(pageState: .LOADING)
        let api : THApi = THApi()
        api.getEvents(viewController: self, delegate: self)
    }
    func showEvents(eventResponse : GetEventResponse)
    {
        if(eventResponse.events != nil)
        {
            RealmHepler.sharedInstance.saveEvents(events: eventResponse.events)
        }
        eventSource = EventTableSource()
        eventSource.datasource = Utils.sharedInstance.groupEvents(events: RealmHepler.sharedInstance.getEvents())
        self.tblEvents.delegate = eventSource
        self.tblEvents.dataSource = eventSource
        self.tblEvents.reloadData()
        self.tableHeaderView.setUpcommingCount(count: RealmHepler.sharedInstance.getEvents().count)
    }
    
    override func viewsForStateChange() -> [UIView]! {
        return [tblEvents]
    }
    
    
    
    
    func getEventsSuccess(response: GetEventResponse) {
        
        setPageState(pageState: .DONE)
        self.showEvents(eventResponse: response)
    }
    
    func getEventFailed(errorCode: Int) {
        setPageState(pageState: .DONE)
    }
    
}

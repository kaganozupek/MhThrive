//
//  RealmHepler.swift
//  My Thrive
//
//  Created by Kagan Ozupek on 7/24/17.
//  Copyright © 2017 Kagan Ozupek. All rights reserved.
//

import UIKit
import RealmSwift
class RealmHepler: NSObject {

    static let sharedInstance = RealmHepler()
    func saveEvents(events : [Event])
    {
        let realm = try! Realm()
        try! realm.write {
            realm.add(events, update: true)
        }
    }
    
    func getEvents() -> Results<Event>
    {
        let realm = try! Realm()
        return realm.objects(Event.self).sorted(byKeyPath: "start_date", ascending: false)
    }
}

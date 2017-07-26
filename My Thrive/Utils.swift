//
//  Utils.swift
//  My Thrive
//
//  Created by Kagan Ozupek on 7/24/17.
//  Copyright © 2017 Kagan Ozupek. All rights reserved.
//

import UIKit
import RealmSwift
class Utils: NSObject {
    
    
    static let sharedInstance = Utils()
    
    func loadEventJson() -> String!
    {
        do{
            let filePath : String = Bundle.main.path(forResource: "bemetest", ofType: "json")!
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
            return String(data: data, encoding: .utf8)!
        }catch
        {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    
    func groupEvents(events : Results<Event>) -> [Any]!
    {
        var groupedObjects : [Date:[Event]?] = [Date:[Event]?]()
        for event : Event in events{
            let date : Date = dateWithoutTIme(input: event.start_date)
            
            if groupedObjects.index(forKey: date) != nil {
                
                var events :[Event]! = groupedObjects[date]!
                events.append(event)
                groupedObjects[date] = events
            }else
            {
                var events :[Event]! = [Event]()
                events.append(event)
                groupedObjects[date] = events
                
            }
            
            
            
        }
        
        var result = [Any]()
        
        
        let itemResult = groupedObjects.sorted { (first: (key: Date, value: [Event]?), second: (key: Date, value: [Event]?)) -> Bool in
            return first.key.timeIntervalSince1970 < second.key.timeIntervalSince1970
        }
        
        
        for (key,element) in itemResult {
            print("key \(key)")
            result.append(key)
            for event : Event in element!{
            
                result.append(event)
            }
            
        }
        
        
        return result
    }
    
    func dateWithoutTIme(input : NSDate) -> Date
    {
        let inputDate : Date = convertNSDateToDate(input: input)
        let unitFlags = Set<Calendar.Component>([.year, .month, .day, .timeZone, .hour , .minute])
        
        let compontents = NSCalendar.current.dateComponents(unitFlags, from: inputDate)
        let output : Date = NSCalendar.current.date(from: compontents)!
        return output
        
    }
    
    func convertNSDateToDate(input : NSDate) -> Date
    {
        let output = Date(timeIntervalSince1970: input.timeIntervalSince1970)
        return output
        
    }
    
    func convertDateToNSDate(input : Date) -> NSDate
    {
        let output = NSDate(timeIntervalSince1970: input.timeIntervalSince1970)
        return output
        
    }
    
    func getEventTimeIntervalText(event : Event) -> String
    {
        let startTime = getTimeTextFromDate(date: event.start_date)
        let endTime = getTimeTextFromDate(date: event.end_date)
        
        return "\(startTime) - \(endTime)"
    }
    
    func getTimeTextFromDate(date : NSDate) -> String
    {
        let nsDateObject = convertNSDateToDate(input: date)
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: nsDateObject)
        let minutes = calendar.component(.minute, from: nsDateObject)
        
        return "\(hour):\(minutes)"
    }
    
    func convertDateToLocalizedText(date : Date) -> String
    {
        let currentDate = dateWithoutTIme(input: NSDate())
        if(currentDate == date)
        {
            return "TODAY"
        }else if(date == getYesterdayDate(date: currentDate))
        {
            return "YESTERDAY"
        }else
        {
            return getDateAsString(date:date)
        }
        
        
    }
    
    func getDateAsString(date : Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM,EEEE"
        
        let dateString = formatter.string(from: date)
        return dateString.uppercased()
    }
    
    func getDateAsStringForForm(date : Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM,EEEE YYYY"
        
        let dateString = formatter.string(from: date)
        return dateString.uppercased()
    }
    
    
    func getTimeAsStringForForm(date : Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh : mm a"
        
        let dateString = formatter.string(from: date)
        return dateString.uppercased()
    }
    
    func getYesterdayDate(date : Date) -> Date
    {
        var dayComp = DateComponents()
        dayComp.day = -1
        let date = Calendar.current.date(byAdding: dayComp, to: date)
        return date!
    }
    
    func isOnIpad() -> Bool
    {
        
          
        #if os(iOS)
            return UIDevice.current.userInterfaceIdiom == .pad
        #else
            return false
        #endif
    }
    
    func setTimeToDate(date : Date,time : Date) -> Date
    {
        
        let unitFlags = Set<Calendar.Component>([.year, .month, .day, .hour , .minute])
        var dateCompontents = NSCalendar.current.dateComponents(unitFlags, from: date)
        var timeCompontents = NSCalendar.current.dateComponents(unitFlags, from: time)
        
        dateCompontents.hour = timeCompontents.hour
        dateCompontents.minute = timeCompontents.minute
        
        
        return NSCalendar.current.date(from: dateCompontents)!
        
        
        
    }
    
    func randomStringWithLength (len : Int) -> NSString {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        let randomString : NSMutableString = NSMutableString(capacity: len)
        
        for _ in 0 ..< len{
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.character(at: Int(rand)))
        }
        
        return randomString
    }
    
    
    func getErrorLocalizedDescription(errorCode : Int) -> String
    {
        switch errorCode {
        case Constants.apiErrorCodeInternalError:
            return "Internal Error Occured\nTap to retry"
        case Constants.apiErrorCodeUnknown:
            return "Internal Error Occured\nTap to retry"
        case Constants.apiErrorCodeUnspecified:
            return "Unknown Unspecified Occured\nTap to retry"
            
        default:
            return ""
            
        }
    
    
    }
}





//
//  EveryDayModel.swift
//  Kaiyan-Swift
//
//  Created by 迅牛 on 16/2/19.
//  Copyright © 2016年 juvham. All rights reserved.
//

import Foundation
import Alamofire

public var kEveryDay = "http://baobab.wandoujia.com/api/v1/feed?num=10&date=%@&vc=67&u=011f2924aa2cf27aa5dc8066c041fe08116a9a0c&v=1.8.0&f=iphone"

class EveryDayModel: NSObject {
    
    var category : String?
    
    var collectionCount : Int = 0
    var replyCount : Int = 0
    var shareCount : Int = 0
    var coverBlurred : String?
    var coverForDetail : String?
    var descrip : String?
    var ID : String?
    var duration : String?
    var title : String?
    var playUrl : String?
    

    class func request() -> Request{
        
        let dateformatter : NSDateFormatter = {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "yyyyMMdd"
            return formatter
        }()
        let date = NSDate()
        let string = dateformatter.stringFromDate(date)
        let url =  String(format: kEveryDay, arguments: [string])
        return Alamofire.request(.POST, url)
    }

}

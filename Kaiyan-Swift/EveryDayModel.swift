//
//  EveryDayModel.swift
//  Kaiyan-Swift
//
//  Created by 迅牛 on 16/2/19.
//  Copyright © 2016年 juvham. All rights reserved.
//

import Foundation
import Alamofire
import Gloss

public var kEveryDay = "http://baobab.wandoujia.com/api/v1/feed?num=10&date=%@&vc=67&u=011f2924aa2cf27aa5dc8066c041fe08116a9a0c&v=1.8.0&f=iphone"

struct PlayInfo :Decodable {
    
    var     height : String?
    var     width: String?
    var     name : String?
    var     type: String?
    var     url : String?
   
    init?(json: JSON) {
        
        self.height = "height" <~~ json
        self.width = "width" <~~ json
        self.name = "name" <~~ json
        self.type = "type" <~~ json
        self.url = "url" <~~ json
    }
    
}

struct PageModel : Decodable {
    var dailyList : Array<EveryDayModel>?
    var nextPageUrl : String?
    var nextPublishTime : Int?
    
    init?(json: JSON) {
        
//        guard let nextPublishTime : String = "nextPublishTime" <~~ json
//            else { return nil}
        
//        let array = json["dailyList"] as! [JSON]
//
//        guard let dailyList :[EveryDayModel] = EveryDayModel.modelsFromJSONArray(array)
//            else { /* handle nil object here */
//        return nil
//        }
        
        self.dailyList = "dailyList" <~~ json
        self.nextPageUrl = "nextPageUrl" <~~ json
        self.nextPublishTime = "nextPublishTime" <~~ json
    }
}

struct EveryDayModel: Decodable {
    var date : Int?
    var total : Int?
    var videoList : Array<VideoModel>?
    
    init?(json: JSON) {
        self.date = "date" <~~ json
        self.total = "total" <~~ json
        self.videoList = "videoList" <~~ json
        
    }
}

struct Consumption : Decodable{
    var collectionCount : Int?
    var playCount : Int?
    var replyCount : Int?
    var shareCount : Int?
    
    init?(json: JSON) {
        self.collectionCount = "collectionCount" <~~ json
        self.playCount = "playCount" <~~ json
        self.replyCount = "replyCount" <~~ json
        self.shareCount = "shareCount" <~~ json

    }
}

struct Provider : Decodable {
    var alias : String?
    var icon : String?
    var name : String?
    
    init?(json: JSON) {
        
        self.alias = "playCount" <~~ json
        self.icon = "replyCount" <~~ json
        self.name = "shareCount" <~~ json
    }
}

struct VideoModel: Decodable {
    
    var adTrack : String?
    var author : String?
    var category : String?
    var consumption : Consumption?
    var coverBlurred : String?
    var coverForDetail : String?
    var coverForFeed : String?
    var coverForSharing : String?
    var date : String?
    var description : String?
    var duration : Int?
    var favoriteAdTrack : String?
    var id : String?
    var idx : String?
    var playInfo : Array<PlayInfo>?
    var playUrl : String?
    var promotion : String?
    var provider : Provider?
    var rawWebUrl : String?
    var shareAdTrack : String?
    var title : String?
    var waterMarks : String?
    var webAdTrack : String?
    var webUrl : String?
    
    init?(json: JSON) {
        
        self.adTrack = "adTrack" <~~ json
        self.author = "author" <~~ json
        self.category = "category" <~~ json
        self.consumption = "consumption" <~~ json
        self.coverBlurred = "coverBlurred" <~~ json
        self.coverForDetail = "coverForDetail" <~~ json
        self.coverForFeed = "coverForFeed" <~~ json
        self.coverForSharing = "coverForSharing" <~~ json
        self.date = "date" <~~ json
        self.description = "description" <~~ json
        self.duration = "duration" <~~ json
        self.favoriteAdTrack = "favoriteAdTrack" <~~ json
        self.id = "id" <~~ json
        self.idx = "idx" <~~ json
        self.playInfo = "playInfo" <~~ json
        self.playUrl = "playUrl" <~~ json
        self.promotion = "promotion" <~~ json
        self.provider = "provider" <~~ json
        self.rawWebUrl = "rawWebUrl" <~~ json
        self.shareAdTrack = "shareAdTrack" <~~ json
        self.title = "title" <~~ json
        self.waterMarks = "waterMarks" <~~ json
        self.webAdTrack = "webAdTrack" <~~ json
        self.webUrl = "webUrl" <~~ json
    }
    
    static func request() -> Request{
        
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

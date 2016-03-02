//
//  EveryDayViewController.swift
//  Kaiyan-Swift
//
//  Created by 迅牛 on 16/2/19.
//  Copyright © 2016年 juvham. All rights reserved.
//



import UIKit
import Alamofire
import Gloss

class EveryDayViewController: UIViewController ,UITableViewDelegate ,UITableViewDataSource {
    
    @IBOutlet var tableView : UITableView?
    
    var pageData : PageModel?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blueColor()
        
        
        VideoModel.request().responseJSON(completionHandler: { response in
            
            response.response
            
            guard  response.result.isSuccess
                else { return}

            let pageData :PageModel = PageModel(json: response.result.value as! JSON )!
            
            self.pageData = pageData;
            
            if NSThread.currentThread().isMainThread {
                self.tableView?.reloadData()
            } else {
                
                dispatch_async(dispatch_get_main_queue(), {[unowned self] in
                    self.tableView?.reloadData()
                    })
            }
            

        })
    }
    
    func  numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
       guard let count = pageData?.dailyList?.count
        else {
            
            return 0;
        }
        return count;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let count = pageData?.dailyList?[section].videoList?.count
            else {
                
                return 0;
        }
        
        return count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let cell:EveryDayTableViewCell? = tableView.dequeueReusableCellWithIdentifier(EveryDayTableViewCell.moveableCell) as? EveryDayTableViewCell
        
        return cell!
        
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
       
        let videoModel :VideoModel = (pageData?.dailyList?[indexPath.section].videoList?[indexPath.row])!
        let everyDayCell = cell as! EveryDayTableViewCell
        everyDayCell.setModel(videoModel)
        everyDayCell.cellOffset()
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    
            return 0.01;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return kWidth * 0.6
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50;
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let visibleCell : Array<EveryDayTableViewCell> = tableView?.visibleCells as! [EveryDayTableViewCell]
        for  evetryDayCell in visibleCell {
        
            evetryDayCell.cellOffset()
        }

    }
    

}

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
    
   lazy var pageData : EveryDayViewModel = {
    
        let model = EveryDayViewModel()
        return model
        
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blueColor()
        
        tableView?.registerNib(UINib(nibName: "EveryDaySectionHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: EveryDaySectionHeaderView.everyDayHeaderViewReuseIdentifier)
        
        pageData.request { pageModel -> Void in
            self.pageData.pageModel = pageModel
            self.tableView?.reloadData()
        }
    }
    
    func  numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return pageData.dayCount()
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  pageData.videoCount(section)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let cell:EveryDayTableViewCell? = tableView.dequeueReusableCellWithIdentifier(EveryDayTableViewCell.moveableCell) as? EveryDayTableViewCell
        
        return cell!
        
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
       
        let everyDayCell = cell as! EveryDayTableViewCell
        
        everyDayCell.cellOffset()
        guard let videoModel = pageData.videoModelAtIndexPath(indexPath)
            else { return }
        everyDayCell.setModel(videoModel)
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let visibleCell : Array<EveryDayTableViewCell> = tableView?.visibleCells as! [EveryDayTableViewCell]
        for  evetryDayCell in visibleCell {
            evetryDayCell.cellOffset()
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView .dequeueReusableHeaderFooterViewWithIdentifier(EveryDaySectionHeaderView.everyDayHeaderViewReuseIdentifier)
        
        return headerView;
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let headerView = view as! EveryDaySectionHeaderView
        
        guard let dayModel = pageData.everyDayModelAtIndex(section)
            else { return }
        headerView.setModel(dayModel)
        
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    
            return 0.01;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return kWidth * 0.6
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {return 0.01}
        return 50;
    }

}

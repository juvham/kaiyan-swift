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
    
    var rilegoulView : RilegouleView!
    var currentIndexPath : NSIndexPath = NSIndexPath(forRow: 0, inSection: 0)
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let  label = UILabel()
        label.font = UIFont.engLFontOfSize(22);
        label.textColor = UIColor(white: 0.1, alpha: 1)
        label.textAlignment = NSTextAlignment.Center
        label.frame = CGRectMake(0, 0, 150, 44)
        label.text = "Eyepetizer"
        
        self.navigationItem.titleView = label
  
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
        
        
        guard let videoModel = pageData.videoModelAtIndexPath(indexPath)
            else { return }
        everyDayCell.setModel(videoModel)
        everyDayCell.cellOffset()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if scrollView.isEqual(tableView) {
        
            let visibleCell : Array<EveryDayTableViewCell> = tableView?.visibleCells as! [EveryDayTableViewCell]
            for  evetryDayCell in visibleCell {
                evetryDayCell.cellOffset()
            }
        } else if scrollView.isEqual(rilegoulView.contenScroll) {
            
            
            for  subiview in rilegoulView.contenScroll.subviews {
                
                guard subiview.respondsToSelector("imageOffsetX")
                    else { return }
                
                (subiview as! ImageContentView).imageOffsetX()
            }

        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView.isEqual(tableView) {
            
        } else if scrollView.isEqual(rilegoulView.contenScroll) {
        
            let index : Int = Int(floor((scrollView.contentOffset.x - scrollView.frame.size.width / 2) / scrollView.frame.size.width) + 1)
            rilegoulView.currentIndex = index
            
            currentIndexPath = NSIndexPath(forRow: index, inSection: currentIndexPath.section)
            
            tableView?.scrollToRowAtIndexPath(currentIndexPath, atScrollPosition: UITableViewScrollPosition.Middle, animated: false)
            
            tableView?.layoutIfNeeded()
            
        } else {
        
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView .dequeueReusableHeaderFooterViewWithIdentifier(EveryDaySectionHeaderView.everyDayHeaderViewReuseIdentifier)
        
        guard section != 0
            else { return nil}
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    
        
        guard let dayModel = pageData.everyDayModelAtIndex(indexPath.section)
            else { return }
        
        currentIndexPath = indexPath

        rilegoulView = RilegouleView(frame: self.view.bounds, model: dayModel, index: indexPath.row)
        rilegoulView.contenScroll.delegate = self
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! EveryDayTableViewCell
        rilegoulView.animationFrame = cell.convertRect(cell.bounds, toView: nil);
        rilegoulView.offSetY = cell.cellOffset()
        
        let swipeGesture = UISwipeGestureRecognizer(target:self , action: "dissmissRile")
        swipeGesture.direction = UISwipeGestureRecognizerDirection.Up
        rilegoulView.bottomContainer.addGestureRecognizer(swipeGesture)
        view.addSubview(rilegoulView)
        
        rilegoulView.animationShow()
    }
    
    func dissmissRile() {
      
        let cell = tableView!.cellForRowAtIndexPath(currentIndexPath) as! EveryDayTableViewCell
        rilegoulView.targetFrame = cell.convertRect(cell.bounds, toView: nil);
        rilegoulView.targetoffSetY = cell.cellOffset()
        

        rilegoulView.animationDissMiss {
            
            self.rilegoulView = nil
        }
    }

}

//
//  ContentScrollView.swift
//  Kaiyan-Swift
//
//  Created by 迅牛 on 16/3/3.
//  Copyright © 2016年 juvham. All rights reserved.
//

import UIKit

//protocol ContentScrollViewDelegate {
//    
//    func contentScrollView(contentScrollView: ContentScrollView, didSelectAtIndex index:Int)
//    func  contentScrollView(contentScrollView: ContentScrollView, didClose close:Bool)
//}

class ContentScrollView: UIScrollView ,UIScrollViewDelegate {

    var currentIndex: Int = 0
    

    init(frame: CGRect, dayModel: EveryDayModel, index:Int) {
        
        super.init(frame: frame)
        currentIndex = index
        
        contentSize = CGSizeMake( CGFloat(dayModel.videoList.count) * frame.width, frame.height);
        bounces = false
        pagingEnabled = true
        showsHorizontalScrollIndicator = false
        
        contentOffset = CGPointMake(CGFloat(index) * frame.width, 0);
        
        for var idx :Int = 0 ; idx < dayModel.videoList.count ; idx++ {
            
            let videoModel :VideoModel = dayModel.videoList[idx]
            
            let sonView = ImageContentView(frame: CGRectMake(CGFloat(idx) * frame.width, 0, frame.width, frame.height), videoModel: videoModel)
            addSubview(sonView)
            sonView.translatesAutoresizingMaskIntoConstraints = false
            
            addConstraint(NSLayoutConstraint(item: sonView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
            addConstraint(NSLayoutConstraint(item: sonView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
            addConstraint(NSLayoutConstraint(item: sonView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 0))
            addConstraint(NSLayoutConstraint(item: sonView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: CGFloat(idx) * frame.width))
            addConstraint(NSLayoutConstraint(item: sonView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: frame.width))

            if idx == dayModel.videoList.count - 1 {
                
                addConstraint(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: sonView , attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0))
            }
        }
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

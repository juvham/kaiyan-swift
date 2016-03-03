//
//  ImageContentView.swift
//  Kaiyan-Swift
//
//  Created by 迅牛 on 16/3/3.
//  Copyright © 2016年 juvham. All rights reserved.
//

import UIKit

class ImageContentView: UIView {
    
    func imageOffsetX() {
        
        let centerToWindow = convertRect(self.bounds, toView:nil)
        let centerX = CGRectGetMidX(centerToWindow);
        let windowCenter = window!.center;
        
        let cellOffsetX = centerX - windowCenter.x;
        
        let offsetDig =  cellOffsetX / window!.frame.size.height * 2;
        
        let transX = CGAffineTransformMakeTranslation(-offsetDig * kWidth * 0.6, 0);
        
        self.imageView.transform = transX

    }

    lazy var imageView : UIImageView = {
       
        let temp = UIImageView()
        temp.backgroundColor = UIColor.whiteColor()
        temp.contentMode = UIViewContentMode.ScaleAspectFill
        return temp
    }()
    
    init(frame: CGRect ,videoModel: VideoModel) {
        
        super.init(frame: frame)
        clipsToBounds = true
        backgroundColor = UIColor.redColor()
        imageView.frame = CGRectMake(0, 0, frame.width, frame.height)
        imageView.translatesAutoresizingMaskIntoConstraints = false 
        addSubview(imageView)
        
        addConstraint(NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.CenterX, relatedBy:NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.CenterY, relatedBy:NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Height, relatedBy:NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Width, relatedBy:NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0))
        
        imageView.hnk_setImageFromURL(NSURL(string: videoModel.coverForDetail)!)
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

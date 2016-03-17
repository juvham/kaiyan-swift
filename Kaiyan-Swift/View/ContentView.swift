//
//  ContentView.swift
//  Kaiyan-Swift
//
//  Created by 迅牛 on 16/3/3.
//  Copyright © 2016年 juvham. All rights reserved.
//

import UIKit

class ContentView: UIView {

    var model :VideoModel! {
        
        didSet {
            
            imageView.hnk_setImageFromURL(NSURL(string: model.coverBlurred!)!)
        }
    }
    var animationLayer:CALayer = {
        
        let calayer = CALayer()
//        let c
        
        return calayer
    }()
    
    var contentAnimation:CABasicAnimation = {
        
        let changeColor = CABasicAnimation(keyPath:"contents")
        
        changeColor.duration  = 1.0 // For convenience
        changeColor.fillMode = kCAFillModeBoth
        changeColor.removedOnCompletion = false
        changeColor.speed = 0;
        return changeColor
    }()

    
    var imageView: UIImageView = {
       
        let imgView = UIImageView()
        imgView.backgroundColor = UIColor.whiteColor()
        imgView.contentMode = UIViewContentMode.ScaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }()
    
    var coverView: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        imageView.frame = frame
        coverView.frame = frame
        
        animationLayer.frame = frame
        animationLayer.position = CGPointMake(0, 0)
        
        addSubview(imageView)
        addSubview(coverView)
        
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 2.0
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        imageView.layer.addAnimation(transition, forKey: "fade")
        
        imageView.layer.addSublayer(animationLayer)
        
        animationLayer.addAnimation(contentAnimation, forKey: "content")
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

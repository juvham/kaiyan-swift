//
//  RilegouleView.swift
//  Kaiyan-Swift
//
//  Created by 迅牛 on 16/3/3.
//  Copyright © 2016年 juvham. All rights reserved.
//

import UIKit
import Haneke

class RilegouleView: UIView {
    
//    var dayModel : EveryDayModel = EveryDayModel(json: Dictionary())!
    var currentIndex : Int! {
        
        didSet {
            contentView.model = model.videoList[currentIndex]
        }
    }
    var offsetY : CGFloat = 0.0
    
    var topContanier : UIView = {
        
        let top = UIView()
        top.clipsToBounds = true
        return top
    }()
    var contentImages:Dictionary<String,UIImage> = Dictionary()
    
    var bottomContainer : UIView = {
       
        let bottom = UIView()
        bottom.clipsToBounds = true
        bottom.backgroundColor =  UIColor.blueColor()
        
        return bottom
    }()
    var model : EveryDayModel!
    
    var contentView : ContentView!
    var contenScroll : ContentScrollView!
    
    var targetoffSetY :CGFloat = 0
    var offSetY : CGFloat {
    
        set(newValue) {
        
            targetoffSetY = newValue
            contenScroll.transform = CGAffineTransformMakeTranslation(0,newValue);
        }
        get {

            return targetoffSetY
        }
    }
    var targetFrame : CGRect = CGRectZero
    var animationFrame : CGRect {
        
        set(newFrame) {
            
            targetFrame = newFrame
            topContanier.frame = newFrame
            bottomContainer.frame = newFrame
            contenScroll.center = CGPointMake(newFrame.width / 2, newFrame.height / 2)
        }
        get {
            return targetFrame
        }
    }
    
    func animationShow() {
        
        UIView.animateWithDuration(0.15, animations: {
            
            self.alpha = 1
            }) { success in
                
                UIView.animateWithDuration(0.25, animations: {
                    self.topContanier.frame = CGRectMake(0, 64, kWidth, kWidth*0.85)
                    self.contenScroll.frame = CGRectMake(0, 0, kWidth, kWidth*0.85)
                    self.contenScroll.center = CGPointMake(self.topContanier.frame.width / 2, self.topContanier.frame.height / 2)
                    
                    self.contenScroll.transform = CGAffineTransformIdentity
                    
                    self.bottomContainer.frame = CGRectMake(0, kWidth*0.85 + 64, kWidth, kHeight - kWidth*0.85 - 64 )
                    
                    self.layoutIfNeeded()
                    }) {  success in
                      
                        
                }
        }
        
    }
    func animationDissMiss(completion: ((Void) -> Void)) {
        
        
        UIView.animateWithDuration(0.25, animations: {
            
            self.topContanier.frame = self.targetFrame;
            self.bottomContainer.frame = self.targetFrame;
             self.contenScroll.frame = CGRectMake(0, 0, kWidth, kWidth*0.7)
            self.contenScroll.center = CGPointMake(self.targetFrame.width / 2, self.self.targetFrame.height / 2)
            self.contenScroll.transform = CGAffineTransformMakeTranslation(0,self.targetoffSetY)
            
            self.layoutIfNeeded()
            }) { succes in
                
                UIView.animateWithDuration(0.15, animations: {
                    self.alpha = 0;
                    }) { success in
                    self.removeFromSuperview()
                    
                        completion()
                }
            
        }
    }
    

    convenience init(frame: CGRect ,model: EveryDayModel ,index: Int) {
        self.init(frame: frame)
//        backgroundColor = UIColor.redColor()
        self.model = model
        alpha = 0;
        addSubview(bottomContainer)
        addSubview(topContanier)
        contenScroll = ContentScrollView(frame: CGRectMake(0, 0, kWidth, kWidth * 0.7), dayModel: model, index: index)
        contentView = ContentView(frame: CGRectMake(0, 0, kWidth, kHeight - kWidth*0.85 - 64 ))
        bottomContainer.addSubview(contentView)
        topContanier.addSubview(contenScroll)
        currentIndex = index
        contentView.model = model.videoList[currentIndex]
        
        for mod in model.videoList {
            let cache = Shared.imageCache
            let URL = NSURL(string: mod.coverBlurred!)!
            let fetcher = NetworkFetcher<UIImage>(URL: URL)
            cache.fetch(fetcher: fetcher).onSuccess { image in
                // Do something with image
                
                self.contentImages.updateValue(image, forKey: mod.coverBlurred!)
            }
        }
    }
    
    func animationToAfter(next :Bool , progress :Double) {
        
        var nextIndex:Int = currentIndex
        if next {
            
            nextIndex =  min(model.videoList.count - 1, currentIndex + 1) ;
        } else {
            
            nextIndex =  max(0,currentIndex - 1);
        }
        
        
        guard nextIndex != currentIndex
            else {
                return
        }
        
//        contentView.animationLayer.contents = contentView.imageView.image
        
        let image = contentImages[model.videoList[nextIndex].coverBlurred!]
        
        guard let _:UIImage = image
            else {
                
                return
        }
        
        contentView.contentAnimation.fromValue = contentView.imageView.image?.CGImage
        contentView.contentAnimation.toValue = image?.CGImage

        
        contentView.animationLayer.timeOffset = progress
        
}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        
        super.init(coder: aDecoder);
    }
    


    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

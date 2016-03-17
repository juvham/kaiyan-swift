//
//  LoadingViewController.swift
//  Kaiyan-Swift
//
//  Created by 迅牛 on 16/1/29.
//  Copyright © 2016年 juvham. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    
    lazy var splashImageView :UIImageView = {
        
        var tempImageView = UIImageView(frame:  UIView.ScreenBounds() )
        tempImageView.contentMode = UIViewContentMode.ScaleToFill
        tempImageView.image =  UIImage(named: "ULaunchImage")
        tempImageView.tintColor = UIColor(white: 0.9, alpha: 1)
        tempImageView.userInteractionEnabled = false
        return tempImageView
    }()
    
    lazy var backImageView :UIImageView = {
        
        var tempImageView = UIImageView(frame:  UIView.ScreenBounds() )
        tempImageView.contentMode = UIViewContentMode.ScaleToFill
        tempImageView.image = UIImage(named: "Splash_BKG")
        tempImageView.userInteractionEnabled = false
        return tempImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.userInteractionEnabled = true
        // Do any additional setup after loading the view.
        self.view.addSubview(backImageView);
        self.view.addSubview(splashImageView);

    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        animation()
    }
    
    func animation () {
        
        let image = UIImage(named:"SLaunchImage")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        let contentsAnimation = CATransition()
        contentsAnimation.type = kCATransitionFade
        contentsAnimation.duration = 1
        contentsAnimation.removedOnCompletion = true
        splashImageView.layer.addAnimation(contentsAnimation, forKey: "contentsAnimation")
        splashImageView.image = image

        let translationAnimation = CABasicAnimation(keyPath: "position")
        translationAnimation.fromValue =  NSValue(CGPoint:splashImageView.layer.position)
        translationAnimation.toValue = NSValue(CGPoint:CGPointMake(splashImageView.layer.position.x ,splashImageView.layer.position.y - 100))
        translationAnimation.fillMode = kCAFillModeForwards
        translationAnimation.duration = 0.6
        translationAnimation.beginTime = CACurrentMediaTime() + 1.0
        translationAnimation.removedOnCompletion = false
           translationAnimation.delegate = self
        splashImageView.layer.addAnimation(translationAnimation, forKey: "translationAnimation")
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1
        scaleAnimation.toValue = 1.1

        scaleAnimation.fillMode = kCAFillModeForwards
        scaleAnimation.duration = 2

        scaleAnimation.beginTime = CACurrentMediaTime() + 0.3
        scaleAnimation.removedOnCompletion = false
        backImageView.layer.addAnimation(scaleAnimation, forKey: "scaleAnimation")
        
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        
        if flag {
            
            UIView.animateWithDuration(0.6, delay: 1, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                    self.view.alpha = 0
                NSNotificationCenter.defaultCenter().postNotificationName("LoadingAnimationFinish", object: nil)
                }, completion: { (Bool) -> Void in
                
                    self.view.removeFromSuperview()
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

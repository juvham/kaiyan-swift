//
//  UIView+Extension.swift
//  Kaiyan-Swift
//
//  Created by 迅牛 on 16/1/29.
//  Copyright © 2016年 juvham. All rights reserved.
//

import UIKit

extension UIView {
    
    class func ScreenBounds() -> CGRect{
        
        return UIScreen.mainScreen().bounds
    }
    
}

extension UINavigationController {
    
    public override func childViewControllerForStatusBarHidden() -> UIViewController? {
        
        return self.topViewController
    }
    
    public override func childViewControllerForStatusBarStyle() -> UIViewController? {
        
        return self.topViewController
    }
}
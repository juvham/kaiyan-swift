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

extension UIFont {
    
   class func chzFontOfSize(fontSize: CGFloat) -> UIFont {
        guard let font = UIFont(name: "FZLTXIHJW--GB1-0", size: fontSize)
            else { return systemFontOfSize(fontSize)}
       return font
    }
    
    class func chzBoldFontOfSize(fontSize: CGFloat) -> UIFont {
        guard let font = UIFont(name: "FZLTZCHJW--GB1-0", size: fontSize)
            else {
                return systemFontOfSize(fontSize)
        }
        return font
    }
    
    class func engLFontOfSize(fontSize: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Lobster 1.4", size: fontSize)
            else {
                return systemFontOfSize(fontSize)
        }
        return font
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
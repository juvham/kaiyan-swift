//
//  ViewController.swift
//  Kaiyan-Swift
//
//  Created by 迅牛 on 16/1/29.
//  Copyright © 2016年 juvham. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var didLoading :Bool = false
    
    lazy var splashViewController: LoadingViewController = {
        var tempView = LoadingViewController()
        tempView.view.frame = UIView.ScreenBounds()
        tempView.view.backgroundColor = UIColor.redColor()
        return tempView;
    }()
    
    var mainNavigation :UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.cyanColor()
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"loadingFinish", name: "LoadingAnimationFinish", object: nil)
        mainNavigation = self.storyboard?.instantiateViewControllerWithIdentifier("mainNavigation") as? UINavigationController
        self.addChildViewController(mainNavigation!)
        mainNavigation?.didMoveToParentViewController(self)
        self.view.addSubview((mainNavigation?.view)!)
        
        self.addChildViewController(splashViewController)
        splashViewController.didMoveToParentViewController(self)
        self.view.addSubview(splashViewController.view)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadingFinish() {
        
        didLoading = true;
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.setNeedsStatusBarAppearanceUpdate()
    }

    override func prefersStatusBarHidden() -> Bool {
        
        return true
    }
    
    override func childViewControllerForStatusBarHidden() -> UIViewController? {
        
        return didLoading ? mainNavigation : nil
    }
    
    override func childViewControllerForStatusBarStyle() -> UIViewController? {
        return didLoading ? mainNavigation : nil
    }
}


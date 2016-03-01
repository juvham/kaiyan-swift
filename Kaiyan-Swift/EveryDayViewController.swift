//
//  EveryDayViewController.swift
//  Kaiyan-Swift
//
//  Created by 迅牛 on 16/2/19.
//  Copyright © 2016年 juvham. All rights reserved.
//

import UIKit
import Alamofire

class EveryDayViewController: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blueColor()
        
        EveryDayModel.request()
            
//            .responseJSON { response in
//            
//            response.response
//            
//            print("\(response)")
//    
//        }
    }

}

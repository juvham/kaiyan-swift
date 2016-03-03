//
//  EveryDaySectionHeaderView.swift
//  Kaiyan-Swift
//
//  Created by 迅牛 on 16/3/2.
//  Copyright © 2016年 juvham. All rights reserved.
//

import UIKit



class EveryDaySectionHeaderView: UITableViewHeaderFooterView {
    
    static var everyDayHeaderViewReuseIdentifier : String = "everyDayHeaderViewReuseIdentifier"
    
    static let dateFormatter : NSDateFormatter = {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMM.dd"
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US")
        
        return dateFormatter;
    }()

    @IBOutlet weak var label: UILabel!

    override func awakeFromNib() {
        
        label.font = UIFont.engLFontOfSize(18);
        label.textColor = UIColor(white: 0.3, alpha: 1);
    }
    func setModel(model : EveryDayModel ) {
    
        guard let dateNumber = model.date
            else {
               
                return
        }

        let date = NSDate(timeIntervalSince1970: dateNumber / 1000)
        let string = EveryDaySectionHeaderView.dateFormatter.stringFromDate(date)
        label.text = String(format: "-%@-", arguments: [string])
    
    }
}

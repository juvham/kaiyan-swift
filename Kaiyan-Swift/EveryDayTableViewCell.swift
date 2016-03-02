//
//  EveryDayTableViewCell.swift
//  Kaiyan-Swift
//
//  Created by 迅牛 on 16/3/2.
//  Copyright © 2016年 juvham. All rights reserved.
//

import UIKit
import Haneke

var kWidth = UIScreen.mainScreen().bounds.size.width
var kHeight = UIScreen.mainScreen().bounds.size.height



class EveryDayTableViewCell: UITableViewCell {
    static var moveableCell :String = "moveableCell"
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var littileLabel: UILabel!
    @IBOutlet weak var moveableImageView: UIImageView!
    @IBOutlet weak var coverView: UIView!
    
    override func awakeFromNib() {
    
        selectionStyle = UITableViewCellSelectionStyle.None
        
        titleLabel.font = UIFont.chzBoldFontOfSize(17);
        littileLabel.font = UIFont.chzFontOfSize(12);
    }
    
    func cellOffset() -> CGFloat {
        
        let centerToWindow = self.convertRect(self.bounds , toView:self.window)
        
        let centerY =  CGRectGetMidY(centerToWindow)
        
        let windowCenter = self.superview!.center;
        
        let cellOffsetY = centerY - windowCenter.y;
        
        let offsetDig = cellOffsetY / ((self.superview!.frame.size.height) / 2);
        let offset =  -offsetDig * (kWidth * 0.2);
        
        let transY = CGAffineTransformMakeTranslation(0,offset);
        
        self.moveableImageView.transform = transY;
        
        return offset;
        
    }
    
    func setModel(videoModel: VideoModel) {

        moveableImageView.hnk_setImageFromURL(NSURL(string: videoModel.coverForDetail!)!)

        titleLabel.text = videoModel.title
            
            // 转换时间
        let time : Int = videoModel.duration!
        let timeString =  String(format: "%02ld'%02ld''", arguments:[time/60,time%60])//显示的是音乐的总时间
        let string =  String(format:"#%@ / %@", arguments:[videoModel.category!,timeString])
            littileLabel.text = string
    }


}

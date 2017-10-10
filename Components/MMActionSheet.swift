//
//  MMActionSheet.swift
//  swiftui
//
//  Created by 郭永红 on 2017/10/9.
//  Copyright © 2017年 keeponrunning. All rights reserved.
//

import UIKit

//常量
let buttonHeight = 44                             /* button高度 */
let screenBounds = UIScreen.main.bounds           /* 屏幕Bounds */
let screenSize   = screenBounds.size              /* 屏幕大小 */
let screenWidth  = screenSize.width               /* 屏幕宽度 */
let screenHeight = screenSize.height              /* 屏幕高度 */

class MMActionSheet: UIView {
    
    var title:String?     //标题
    var buttons:Array<Dictionary<String, Any>>?    //按钮组
    var duration: Double?  //动画时长
    var cancel: Bool?     //点击背景是否隐藏
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(title: String?, buttons: Array<Dictionary<String, Any>>?, duration: Double?, cancel: Bool?) {
        let btnCount = buttons?.count ?? 0
        let aFrame:CGRect = CGRect.init(x: 0, y: screenHeight, width: screenWidth, height: CGFloat(btnCount * buttonHeight + 155))
        self.init(frame: aFrame)
        self.title = title ?? ""
        self.buttons = buttons ?? []
        self.duration = duration ?? 0.8
        self.cancel = cancel ?? true
        
        //初始化UI
        initUI()
    }
    
    
    func initUI() {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: 0, y: 0, width: Int(screenWidth), height: buttonHeight)
        if #available(iOS 8.2, *) {
            button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: 100)
        } else {
            // Fallback on earlier versions
        }
        button.setTitle(self.title, for: .normal)
        button.setTitleColor(UIColor(red: 0.000, green: 0.000, blue: 0.004, alpha: 1.00), for: .normal)
        self.addSubview(button)
    }
    
    
    /// 显示
    func present() {
        let btnCount = buttons?.count ?? 0
        UIView.animate(withDuration: self.duration!) {
            var tempFrame = self.frame
            tempFrame.origin.y = screenHeight - CGFloat(btnCount * buttonHeight) - 155
            self.frame = tempFrame
        }
    }
    
    /// 隐藏
    func dismiss() {
        UIView.animate(withDuration: self.duration!) {
            var tempFrame = self.frame
            tempFrame.origin.y = screenHeight
            self.frame = tempFrame
        }
    }
    
    /// 修改样式
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.941, alpha: 0.90)
    }
    
    
}

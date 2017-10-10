//
//  MMActionSheet.swift
//  swiftui
//
//  Created by 郭永红 on 2017/10/9.
//  Copyright © 2017年 keeponrunning. All rights reserved.
//

import UIKit

//常量
let divideLineHeight:CGFloat = 1                     /* 按钮与按钮之间的分割线高度 */
let screenBounds = UIScreen.main.bounds              /* 屏幕Bounds */
let screenSize   = screenBounds.size                 /* 屏幕大小 */
let screenWidth  = screenSize.width                  /* 屏幕宽度 */
let screenHeight = screenSize.height                 /* 屏幕高度 */
let buttonHeight:CGFloat = 48.0 * screenWidth / 375  /* button高度 */
let titleHeight:CGFloat = 40.0 * screenWidth / 375   /* 标题的高度 */
let btnPadding:CGFloat = 5 * screenWidth / 375       /* 取消按钮与其他按钮之间的间距 */
let defaultDuration = 0.4


typealias actionClickBlock = (String) ->()

class MMActionSheet: UIView {
    
    var title:String?     //标题
    var buttons:Array<Dictionary<String, String>>?    //按钮组
    var duration: Double?  //动画时长
    var cancel: Bool?     //是否需要取消按钮
    
    var actionSheetHeight:CGFloat = 0
    var actionSheetView:UIView = UIView()
    var callBack:actionClickBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// 初始化
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - buttons: 按钮数组
    ///   - duration: 动画时长
    ///   - cancel: 是否需要取消按钮
    convenience init(title: String?, buttons: Array<Dictionary<String, String>>?, duration: Double?, cancel: Bool?) {
        
        //半透明背景
        self.init(frame: screenBounds)
        self.title = title ?? ""
        self.buttons = buttons ?? []
        self.duration = duration ?? defaultDuration
        self.cancel = cancel ?? true
        //添加单击事件，隐藏sheet
        let singleTap = UITapGestureRecognizer.init(target: self, action: #selector(self.singleTapDismiss))
        singleTap.delegate = self
        self.addGestureRecognizer(singleTap)
        
        //actionSheet
        initActionSheet()
        //初始化UI
        initUI()
    }
    
    func initActionSheet() {
        let btnCount = buttons?.count ?? 0
        var tHeight:CGFloat = 0.0
        if (self.title != nil && self.title != "")   {
            tHeight = titleHeight
        }
        
        var cancelHeight:CGFloat = 0.0
        if self.cancel == true {
            cancelHeight = buttonHeight + btnPadding
        }
        
        actionSheetHeight = CGFloat(btnCount) * buttonHeight + tHeight + cancelHeight + CGFloat(btnCount) * divideLineHeight
        let aFrame:CGRect = CGRect.init(x: 0, y: screenHeight, width: screenWidth, height: actionSheetHeight)
        self.actionSheetView.frame = aFrame
        self.addSubview(self.actionSheetView)
    }
    
    func initUI() {
        
        //标题不为空，则添加标题
        if (self.title != nil && self.title != "")  {
            let titlelabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: titleHeight))
            titlelabel.text = self.title
            titlelabel.textAlignment = .center
            titlelabel.textColor = UIColor.lightGray
            titlelabel.font = UIFont.systemFont(ofSize: 14)
            titlelabel.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.941, alpha: 0.90)
            self.actionSheetView.addSubview(titlelabel)
        }
        
        //事件按钮组
        let buttonsCount = self.buttons?.count ?? 0
        for index in 0..<buttonsCount {
            let btn = self.buttons![index]
            
            var tHeight:CGFloat = 0.0
            if (self.title != nil && self.title != "")   {
                tHeight = titleHeight
            }
            
            let origin_y = tHeight + buttonHeight * CGFloat(index) + divideLineHeight * CGFloat(index)
            
            let button = DDButton.init(type: .custom)
            button.frame = CGRect.init(x: 0.0, y: origin_y, width: screenWidth, height: buttonHeight)
            if #available(iOS 8.2, *) {
                button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            } else {
                // Fallback on earlier versions
            }
            button.handler = btn["handler"]
            button.setTitle(btn["title"], for: .normal)
            var titleColor:UIColor = UIColor(red: 0.000, green: 0.000, blue: 0.004, alpha: 1.00)
            switch(btn["color"]) {
            case "blue"?:
                titleColor = UIColor(red: 0.082, green: 0.494, blue: 0.984, alpha: 1.00)
                break
            case "danger"?:
                titleColor = UIColor.red
                break
            default:
                titleColor = UIColor(red: 0.000, green: 0.000, blue: 0.004, alpha: 1.00)
            }
            button.setTitleColor(titleColor, for: .normal)
            button.setBackgroundImage(self.imageWithColor(color: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.80), size: button.bounds.size), for: .normal)
            button.setBackgroundImage(self.imageWithColor(color: UIColor(red: 0.780, green: 0.733, blue: 0.745, alpha: 0.80), size: button.bounds.size), for: .highlighted)
            button.addTarget(self, action: #selector(self.actionClick), for: .touchUpInside)
            self.actionSheetView.addSubview(button)
        }
        
        //如果取消为ture则添加取消按钮
        if self.cancel == true {
            let button = DDButton.init(type: .custom)
            button.frame = CGRect.init(x: 0, y: Int(self.actionSheetView.bounds.size.height - buttonHeight), width: Int(screenWidth), height: Int(buttonHeight))
            if #available(iOS 8.2, *) {
                button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            } else {
                // Fallback on earlier versions
            }
            button.handler = "cancel"
            button.setTitle("取消", for: .normal)
            button.setTitleColor(UIColor(red: 0.000, green: 0.000, blue: 0.004, alpha: 1.00), for: .normal)
            button.setBackgroundImage(self.imageWithColor(color: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.80), size: button.bounds.size), for: .normal)
            button.setBackgroundImage(self.imageWithColor(color: UIColor(red: 0.780, green: 0.733, blue: 0.745, alpha: 0.80), size: button.bounds.size), for: .highlighted)
            button.addTarget(self, action: #selector(self.actionClick), for: .touchUpInside)
            self.actionSheetView.addSubview(button)
        }
        
        
    }
    
    func actionClick(button:DDButton) {
        self.dismiss()
        if (self.callBack != nil) {
            self.callBack!(button.handler!)
        }
    }
    
    func singleTapDismiss() {
//        点击背景屏幕不取消
//        if self.cancel == false {
//            return
//        }
        self.dismiss()
        if (self.callBack != nil) {
            self.callBack!("cancel")
        }
    }
    
    /// 显示
    func present() {
        UIView.animate(withDuration: 0.1, animations: {
            UIApplication.shared.keyWindow?.addSubview(self)
            self.actionSheetView.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.941, alpha: 0.90).withAlphaComponent(0.9)
        }) { (finished:Bool) in
            UIView.animate(withDuration: self.duration!) {
                self.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.3)
                var tempFrame = self.actionSheetView.frame
                tempFrame.origin.y = screenHeight - self.actionSheetHeight
                self.actionSheetView.frame = tempFrame
            }
        }
        
    }
    
    /// 隐藏
    func dismiss() {
        UIView.animate(withDuration: self.duration!, animations: {
            self.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
            var tempFrame = self.actionSheetView.frame
            tempFrame.origin.y = screenHeight
            self.actionSheetView.frame = tempFrame
        }) { (finished:Bool) in
            self.removeFromSuperview()
        }
    }
    
    /// 修改样式
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        self.actionSheetView.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.941, alpha: 0.90).withAlphaComponent(0.9)
    }
    
    func imageWithColor(color:UIColor,size:CGSize) ->UIImage{
        let rect = CGRect(x:0, y:0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

extension MMActionSheet: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view == self.actionSheetView {
            return false
        }
        return true
    }
}

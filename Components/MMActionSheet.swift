//
//  MMActionSheet.swift
//  swiftui
//
//  Created by 郭永红 on 2017/10/9.
//  Copyright © 2017年 keeponrunning. All rights reserved.
//

import UIKit

//常量
let mmdivideLineHeight:CGFloat = 1                       /* 按钮与按钮之间的分割线高度 */
let mmscreenBounds = UIScreen.main.bounds                /* 屏幕Bounds */
let mmscreenSize   = mmscreenBounds.size                 /* 屏幕大小 */
let mmscreenWidth  = mmscreenSize.width                  /* 屏幕宽度 */
let mmscreenHeight = mmscreenSize.height                 /* 屏幕高度 */
let mmbuttonHeight:CGFloat = 48.0 * mmscreenWidth / 375  /* button高度 */
let mmtitleHeight:CGFloat = 40.0 * mmscreenWidth / 375   /* 标题的高度 */
let mmbtnPadding:CGFloat = 5 * mmscreenWidth / 375       /* 取消按钮与其他按钮之间的间距 */
let mmdefaultDuration = 0.3

public typealias actionClickBlock = (String) ->()

public class MMActionSheet: UIView {
    var title:String?     //标题
    var buttons:Array<Dictionary<String, String>>?    //按钮组
    var duration: Double?  //动画时长
    var cancelButton: Dictionary<String, String>?     //取消按钮
    
    var actionSheetHeight:CGFloat = 0
    public var actionSheetView:UIView = UIView()
    
    public var callBack:actionClickBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// 初始化
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - buttons: 按钮数组
    ///   - duration: 动画时长
    ///   - cancel: 是否需要取消按钮
    convenience public init(title: String?, buttons: Array<Dictionary<String, String>>?, duration: Double?, cancelBtn: Dictionary<String, String>?) {
        
        //半透明背景
        self.init(frame: mmscreenBounds)
        self.title = title ?? ""
        self.buttons = buttons ?? []
        let btnCount = self.buttons?.count ?? 0
        self.duration = duration ?? (mmdefaultDuration + mmdefaultDuration * Double(btnCount/30))
        self.cancelButton = cancelBtn ?? [:]
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
            tHeight = mmtitleHeight
        }
        
        var cancelHeight:CGFloat = 0.0
        if self.cancelButton! != [:] {
            cancelHeight = mmbuttonHeight + mmbtnPadding
        }
        
        actionSheetHeight = CGFloat(btnCount) * mmbuttonHeight + tHeight + cancelHeight + CGFloat(btnCount) * mmdivideLineHeight
        let aFrame:CGRect = CGRect.init(x: 0, y: mmscreenHeight, width: mmscreenWidth, height: actionSheetHeight)
        self.actionSheetView.frame = aFrame
        self.addSubview(self.actionSheetView)
    }
    
    func initUI() {
        
        //标题不为空，则添加标题
        if (self.title != nil && self.title != "")  {
            let titlelabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: mmscreenWidth, height: mmtitleHeight))
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
                tHeight = mmtitleHeight
            }
            
            let origin_y = tHeight + mmbuttonHeight * CGFloat(index) + mmdivideLineHeight * CGFloat(index)
            
            let button = MMButton.init(type: .custom)
            button.frame = CGRect.init(x: 0.0, y: origin_y, width: mmscreenWidth, height: mmbuttonHeight)
            if #available(iOS 8.2, *) {
                button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            } else {
                // Fallback on earlier versions
            }
            button.handler = btn["handler"]
            button.setTitle(btn["title"], for: .normal)
            var titleColor:UIColor = UIColor(red: 0.000, green: 0.000, blue: 0.004, alpha: 1.00)
            switch(btn["type"]) {
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
        if self.cancelButton! != [:] {
            let button = MMButton.init(type: .custom)
            button.frame = CGRect.init(x: 0, y: Int(self.actionSheetView.bounds.size.height - mmbuttonHeight), width: Int(mmscreenWidth), height: Int(mmbuttonHeight))
            if #available(iOS 8.2, *) {
                button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            } else {
                // Fallback on earlier versions
            }
            button.handler = self.cancelButton?["handler"] ?? "cancel"
            button.setTitle(self.cancelButton?["title"] ?? "取消", for: .normal)
            var titleColor:UIColor = UIColor(red: 0.000, green: 0.000, blue: 0.004, alpha: 1.00)
            switch(self.cancelButton!["type"]) {
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
        
        
    }
    
    @objc func actionClick(button:MMButton) {
        self.dismiss()
        if (self.callBack != nil) {
            self.callBack!(button.handler!)
        }
    }
    
    @objc func singleTapDismiss() {
        self.dismiss()
        if (self.callBack != nil) {
            self.callBack!("cancel")
        }
    }
    
    /// 显示
    public func present() {
        UIView.animate(withDuration: 0.1, animations: {
            UIApplication.shared.keyWindow?.addSubview(self)
            self.actionSheetView.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.941, alpha: 0.90).withAlphaComponent(0.9)
        }) { (finished:Bool) in
            UIView.animate(withDuration: self.duration!) {
                self.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.3)
                var tempFrame = self.actionSheetView.frame
                tempFrame.origin.y = mmscreenHeight - self.actionSheetHeight
                self.actionSheetView.frame = tempFrame
            }
        }
        
    }
    
    /// 隐藏
    func dismiss() {
        UIView.animate(withDuration: self.duration!, animations: {
            self.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
            var tempFrame = self.actionSheetView.frame
            tempFrame.origin.y = mmscreenHeight
            self.actionSheetView.frame = tempFrame
        }) { (finished:Bool) in
            self.removeFromSuperview()
        }
    }
    
    /// 修改样式
    override public func layoutSubviews() {
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
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view == self.actionSheetView {
            return false
        }
        return true
    }
}


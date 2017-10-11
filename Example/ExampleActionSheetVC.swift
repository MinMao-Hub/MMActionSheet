//
//  ExampleActionSheetVC.swift
//  swiftui
//
//  Created by 郭永红 on 2017/10/9.
//  Copyright © 2017年 keeponrunning. All rights reserved.
//

import UIKit

class ExampleActionSheetVC: UIViewController {

//    var mmActionSheet:MMActionSheet! = nil
//    var mmActionSheet1:MMActionSheet! = nil
//    var mmActionSheet2:MMActionSheet! = nil
//    var mmActionSheet3:MMActionSheet! = nil
//    var mmActionSheet4:MMActionSheet! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }

    @IBAction func presentActionSheet(_ sender: Any) {
        let buttons = [
            [
                "title": "拍照",
                "handler": "camera",
            ],[
                "title": "相册",
                "handler": "photos",
                "type": "default"
            ]
        ]
        
        let mmActionSheet = MMActionSheet.init(title: "请选择照片", buttons: buttons, duration: nil, cancel: true)
        mmActionSheet.callBack = { (handler) ->() in
            print(handler)
        }
        mmActionSheet.present()
    }
    
    @IBAction func showWechatActionSheet(_ sender: Any) {
        let buttons = [
            [
                "title": "发送给朋友",
                "handler": "sendToFriend",
            ],[
                "title": "收藏",
                "handler": "collection",
                "type": "default"
            ],[
                "title": "保存图片",
                "handler": "save",
            ],[
                "title": "打开",
                "handler": "open",
            ],[
                "title": "编辑",
                "handler": "edit",
            ],[
                "title": "定位到聊天位置",
                "handler": "location",
            ]
        ]
        
        let mmActionSheet1 = MMActionSheet.init(title: nil, buttons: buttons, duration: nil, cancel: true)
        mmActionSheet1.callBack = { (handler) ->() in
            print(handler)
        }
        mmActionSheet1.present()
    }
    
    @IBAction func showNoTitleActionSheet(_ sender: Any) {
        let buttons = [
            [
                "title": "微信",
                "handler": "1",
            ],[
                "title": "QQ",
                "handler": "2",
            ],[
                "title": "支付宝",
                "handler": "3",
            ],[
                "title": "新浪微博",
                "handler": "4",
            ]
        ]
        
        let mmActionSheet2 = MMActionSheet.init(title: nil, buttons: buttons, duration: nil, cancel: false)
        mmActionSheet2.callBack = { (handler) ->() in
            print(handler)
        }
        mmActionSheet2.present()
    }
    
    @IBAction func showNoCancelActionSheet(_ sender: Any) {
        let buttons = [
            [
                "title": "男",
                "handler": "男",
                "type": "blue"
            ],[
                "title": "女",
                "handler": "女",
                "type": "danger"
            ]
        ]
        
        let mmActionSheet3 = MMActionSheet.init(title: "请选择性别", buttons: buttons, duration: nil, cancel: false)
        mmActionSheet3.callBack = { (handler) ->() in
            print(handler)
        }
        mmActionSheet3.present()
    }
    
    @IBAction func showColorTitleActionSheet(_ sender: Any) {
        let buttons = [
            [
                "title": "查看",
                "handler": "check",
                "type": "default"
            ],[
                "title": "编辑",
                "handler": "edit",
                "type": "blue"
            ],[
                "title": "删除",
                "handler": "delete",
                "type": "danger"
            ]
        ]
        
        let mmActionSheet4 = MMActionSheet.init(title: "ActionSheet", buttons: buttons, duration: nil, cancel: true)
        mmActionSheet4.callBack = { (handler) ->() in
            print(handler)
        }
        mmActionSheet4.present()
    }
    
}

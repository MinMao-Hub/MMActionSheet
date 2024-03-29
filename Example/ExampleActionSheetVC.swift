//
//  ExampleActionSheetVC.swift
//  swiftui
//
//  Created by 郭永红 on 2017/10/9.
//  Copyright © 2017年 keeponrunning. All rights reserved.
//

import UIKit

class ExampleActionSheetVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }

    @IBAction func presentActionSheet(_ sender: Any) {
        let buttons = [
            MMButtonItem(title: "拍照", titleColor: .default, buttonType: .default(index: 0)),
            MMButtonItem(title: "相册", titleColor: .default, buttonType: .default(index: 1)),
        ]

        let titleItem = MMTitleItem(title: "请选择照片", titleColor: .red)
        let cancelButton = MMButtonItem(title: "取消", titleColor: .default, buttonType: .cancel)

        let mmActionSheet = MMActionSheet(title: titleItem, buttons: buttons, duration: nil, cancelButton: cancelButton)
        mmActionSheet.selectionClosure = { item in
            if let currentItem = item, let type = currentItem.buttonType {
                switch type {
                case let .default(index):
                    print("== default index \(index) ==")
                case .cancel:
                    print("cancel")
                }
            }
        }
        mmActionSheet.present()
    }

    @IBAction func showWechatActionSheet(_ sender: Any) {
        let buttons = [
            MMButtonItem(title: "发送给朋友", titleColor: .default, buttonType: .default(index: 0)),
            MMButtonItem(title: "收藏", titleColor: .default, buttonType: .default(index: 1)),
            MMButtonItem(title: "保存图片", titleColor: .default, buttonType: .default(index: 2)),
            MMButtonItem(title: "打开", titleColor: .default, buttonType: .default(index: 3)),
            MMButtonItem(title: "编辑", titleColor: .default, buttonType: .default(index: 4)),
            MMButtonItem(title: "定位到聊天位置", titleColor: .default, buttonType: .default(index: 5))        ]
        let cancelButton = MMButtonItem(title: "取消", titleColor: .danger, buttonType: .cancel)
        let mmActionSheet1 = MMActionSheet(title: nil, buttons: buttons, duration: nil, cancelButton: cancelButton)
        mmActionSheet1.selectionClosure = { item in
            if let currentItem = item, let type = currentItem.buttonType {
                switch type {
                case let .default(index):
                    print("== default index \(index) ==")
                case .cancel:
                    print("cancel")
                }
            }
        }
        mmActionSheet1.present()
    }

    @IBAction func showNoTitleActionSheet(_ sender: Any) {
        let buttons = [
            MMButtonItem(title: "微信", titleColor: .default, buttonType: .default(index: 0)),
            MMButtonItem(title: "QQ", titleColor: .default, buttonType: .default(index: 1)),
            MMButtonItem(title: "支付宝", titleColor: .default, buttonType: .default(index: 2)),
            MMButtonItem(title: "新浪微博", titleColor: .default, buttonType: .default(index: 3)),
        ]

        let mmActionSheet2 = MMActionSheet(title: nil, buttons: buttons, duration: nil, cancelButton: nil)
        mmActionSheet2.selectionClosure = { item in
            if let currentItem = item, let type = currentItem.buttonType {
                switch type {
                case let .default(index):
                    print("== default index \(index) ==")
                case .cancel:
                    print("cancel")
                }
            }
        }
        mmActionSheet2.present()
    }

    @IBAction func showNoCancelActionSheet(_ sender: Any) {
        let buttons = [
            MMButtonItem(title: "男", titleColor: .blue, buttonType: .default(index: 0)),
            MMButtonItem(title: "女", titleColor: .danger, buttonType: .default(index: 1)),
        ]
        
        let titleItem = MMTitleItem(title: "请选择性别", titleColor: .purple)

        let mmActionSheet3 = MMActionSheet(title: titleItem, buttons: buttons, duration: nil, cancelButton: nil)
        mmActionSheet3.selectionClosure = { item in
            if let currentItem = item, let type = currentItem.buttonType {
                switch type {
                case let .default(index):
                    print("== default index \(index) ==")
                case .cancel:
                    print("cancel")
                }
            }
        }
        mmActionSheet3.present()
    }

    @IBAction func showColorTitleActionSheet(_ sender: Any) {
        let buttons = [
            MMButtonItem(title: "查看", titleColor: .custom(.red), buttonType: .default(index: 0)),
            MMButtonItem(title: "编辑", titleColor: .custom(.green), buttonType: .default(index: 1)),
            MMButtonItem(title: "删除", titleColor: .custom(.brown), buttonType: .default(index: 2)),
        ]

        let titleItem = MMTitleItem(title: "文件管理", titleColor: .orange, titleFont: .systemFont(ofSize: 18.0))
        let cancelButton = MMButtonItem(title: "返回", titleColor: .custom(.orange), buttonType: .cancel)

        let mmActionSheet4 = MMActionSheet(title: titleItem, buttons: buttons, duration: nil, cancelButton: cancelButton)
        mmActionSheet4.selectionClosure = { item in
            if let currentItem = item, let type = currentItem.buttonType {
                switch type {
                case let .default(index):
                    print("== default index \(index) ==")
                case .cancel:
                    print("cancel")
                }
            }
        }
        mmActionSheet4.present()
    }
    
    @IBAction func showColorBgTitleActionSheet(_ sender: Any) {
        let buttons = [
            MMButtonItem(
                title: "查看",
                buttonType: .default(index: 0),
                backgroudImageColorNormal:.custom(.purple),
                backgroudImageColorHighlight:.custom(.yellow)
            ),
            MMButtonItem(
                title: "编辑",
                buttonType: .default(index: 1),
                backgroudImageColorNormal:.custom(.green)
            ),
            MMButtonItem(
                title: "删除",
                buttonType: .default(index: 2),
                backgroudImageColorNormal:.custom(.red),
                backgroudImageColorHighlight:.custom(.orange)
            )
        ]

        let titleItem = MMTitleItem(title: "文件管理", titleFont: .systemFont(ofSize: 18.0),backgroundColor: .custom(.cyan))
        let cancelButton = MMButtonItem(
            title: "返回",
            titleColor: .custom(.orange),
            buttonType: .cancel,
            backgroudImageColorNormal:.custom(.blue)
        )

        let mmActionSheet4 = MMActionSheet(title: titleItem, buttons: buttons, duration: nil, cancelButton: cancelButton)
        mmActionSheet4.selectionClosure = { item in
            if let currentItem = item, let type = currentItem.buttonType {
                switch type {
                case let .default(index):
                    print("== default index \(index) ==")
                case .cancel:
                    print("cancel")
                }
            }
        }
        mmActionSheet4.present()
    }
    
    @IBAction func showManyTitleActionSheet(_ sender: Any) {
        let buttons = [
            MMButtonItem(title: "发送给朋友", titleColor: .default, buttonType: .default(index: 0)),
            MMButtonItem(title: "收藏", titleColor: .default, buttonType: .default(index: 1)),
            MMButtonItem(title: "保存图片", titleColor: .default, buttonType: .default(index: 2)),
            MMButtonItem(title: "打开", titleColor: .default, buttonType: .default(index: 3)),
            MMButtonItem(title: "编辑", titleColor: .default, buttonType: .default(index: 4)),
            MMButtonItem(title: "定位到聊天位置", titleColor: .default, buttonType: .default(index: 5)),
            MMButtonItem(title: "发送给朋友", titleColor: .default, buttonType: .default(index: 0)),
            MMButtonItem(title: "收藏", titleColor: .default, buttonType: .default(index: 1)),
            MMButtonItem(title: "保存图片", titleColor: .default, buttonType: .default(index: 2)),
            MMButtonItem(title: "打开", titleColor: .default, buttonType: .default(index: 3)),
            MMButtonItem(title: "编辑", titleColor: .default, buttonType: .default(index: 4)),
            MMButtonItem(title: "定位到聊天位置", titleColor: .default, buttonType: .default(index: 5))
        ]

        let titleItem = MMTitleItem(title: "多个选项滚动列表", titleColor: .purple)
        let cancelButton = MMButtonItem(title: "取消", titleColor: .danger, buttonType: .cancel)
        let mmActionSheet1 = MMActionSheet(title: titleItem, buttons: buttons, duration: nil, cancelButton: cancelButton)
        mmActionSheet1.selectionClosure = { item in
            if let currentItem = item, let type = currentItem.buttonType {
                switch type {
                case let .default(index):
                    print("== default index \(index) ==")
                case .cancel:
                    print("cancel")
                }
            }
        }
        mmActionSheet1.present()
    }
    
    @IBAction func showTopCornerActionSheet(_ sender: Any) {
        let buttons = [
            MMButtonItem(title: "查看", buttonType: .default(index: 0)),
            MMButtonItem(title: "编辑", buttonType: .default(index: 1)),
            MMButtonItem(title: "删除", buttonType: .default(index: 2))
        ]

        let titleItem = MMTitleItem(title: "文件管理", titleFont: .systemFont(ofSize: 18.0), backgroundColor: .custom(MMTools.DefaultColor.normalColor))
        let cancelButton = MMButtonItem(title: "返回", buttonType: .cancel)
        
        let mmActionSheet1 = MMActionSheet(title: titleItem, buttons: buttons, duration: nil, cancelButton: cancelButton)
        mmActionSheet1.topCornerRadius = 20
        mmActionSheet1.selectionClosure = { item in
            if let currentItem = item, let type = currentItem.buttonType {
                switch type {
                case let .default(index):
                    print("== default index \(index) ==")
                case .cancel:
                    print("cancel")
                }
            }
        }
        mmActionSheet1.present()
    }
}

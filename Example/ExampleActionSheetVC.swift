//
//  ExampleActionSheetVC.swift
//  swiftui
//
//  Created by 郭永红 on 2017/10/9.
//  Copyright © 2017年 keeponrunning. All rights reserved.
//

import UIKit

class ExampleActionSheetVC: UIViewController {

    var mmActionSheet:MMActionSheet! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
//        let buttons = [
//            {
//                "title": "投诉",
//                "handler": "1",
//                "color": "danger"
//            },
//            {
//                "title": "投诉",
//                "handler": "1",
//                "color": "danger"
//            }
//        ]
        
        mmActionSheet = MMActionSheet.init(title: "请选择照片", buttons: nil, duration: nil, cancel: nil)
        self.view.addSubview(mmActionSheet)
    }

    @IBAction func presentActionSheet(_ sender: Any) {
        mmActionSheet.present()
    }
    
    @IBAction func dismissActionSheet(_ sender: Any) {
        mmActionSheet.dismiss()
    }
    
    
}

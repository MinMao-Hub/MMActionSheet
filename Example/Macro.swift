//
//  Macro.swift
//  swiftui
//
//  Created by 郭永红 on 2017/10/9.
//  Copyright © 2017年 keeponrunning. All rights reserved.
//

import Foundation
import UIKit

let kScreenBounds                         = UIScreen.main.bounds            /* 屏幕Bounds */
let kScreenSize                           = kScreenBounds.size                      /* 屏幕大小 */
let kScreenWidth                          = kScreenSize.width                       /* 屏幕宽度 */
let kScreenHeight                         = kScreenSize.height                      /* 屏幕高度 */
let kNavigationHeight :CGFloat            = UINavigationBar.appearance().frame.size.height  /* 导航条高度 */
let kStatuBarHeight   :CGFloat            = UIApplication.shared.statusBarFrame.size.height  /* 状态栏高度 */
let kNavigationHeightAndStatuBarHeight    = kNavigationHeight + kStatuBarHeight

let kiOSVersion                           = UIDevice.current.systemVersion  /* iOS系统版本 */

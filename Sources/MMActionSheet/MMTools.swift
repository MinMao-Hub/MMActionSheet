//
//  MMTools.swift
//  swiftui
//
//  Created by JefferDevs on 2021/9/13.
//  Copyright © 2021 keeponrunning. All rights reserved.
//

import UIKit

public struct MMTools {
    /// Default
    public struct DefaultColor {
        public static let backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.941, alpha: 0.90).withAlphaComponent(0.9)
        public static let normalColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.80)
        public static let highlightColor = UIColor(red: 0.780, green: 0.733, blue: 0.745, alpha: 0.80)
    }
    
    static var isIphoneX: Bool {
        if #available(iOS 11.0, *) {
            let keyWindow = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
            return keyWindow?.safeAreaInsets.bottom ?? 0 > 0
        } else {
            // Fallback on earlier versions
            return false
        }
    }
    
    static func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

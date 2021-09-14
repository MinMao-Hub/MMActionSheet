//
//  MMTitleItem.swift
//  swiftui
//
//  Created by JefferDevs on 2021/9/13.
//  Copyright © 2021 keeponrunning. All rights reserved.
//

import UIKit

public struct MMTitleItem {
    /// text
    public var text: String?
    /// text color
    public var textColor: UIColor?
    /// textFont
    public var textFont: UIFont? = .systemFont(ofSize: 14.0)
    /// textAlignment
    public var textAlignment: NSTextAlignment? = .center

    public init(title: String?,
                titleColor: UIColor?,
                titleFont: UIFont? = .systemFont(ofSize: 14.0),
                textAlignment: NSTextAlignment? = .center) {
        self.text = title
        self.textColor = titleColor
        self.textFont = titleFont
        self.textAlignment = textAlignment
    }
}

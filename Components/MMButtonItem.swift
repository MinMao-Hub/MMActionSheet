//
//  MMButtonItem.swift
//  swiftui
//
//  Created by JefferDevs on 2021/9/13.
//  Copyright © 2021 keeponrunning. All rights reserved.
//

import UIKit

public struct MMButtonItem {
    /// title
    public var title: String?
    /// titleColor
    public var titleColor: MMButtonTitleColor? = .default
    /// title font
    public var titleFont: UIFont? = .systemFont(ofSize: 16.0)
    /// MMButtonType
    public var buttonType: MMButtonType?
    /// BackgroudImageColor Normal
    public var backgroudImageColorNormal: MMButtonTitleColor? = .custom(MMTools.DefaultColor.normalColor)
    /// BackgroudImageColor Highlight
    public var backgroudImageColorHighlight: MMButtonTitleColor? = .custom(MMTools.DefaultColor.highlightColor)

    public init(title: String?,
                titleColor: MMButtonTitleColor? = .default,
                titleFont: UIFont? = .systemFont(ofSize: 16.0),
                buttonType: MMButtonType?,
                backgroudImageColorNormal: MMButtonTitleColor? = .custom(MMTools.DefaultColor.normalColor),
                backgroudImageColorHighlight: MMButtonTitleColor? = .custom(MMTools.DefaultColor.highlightColor)) {
        self.title = title
        self.titleColor = titleColor
        self.titleFont = titleFont
        self.buttonType = buttonType
        self.backgroudImageColorNormal = backgroudImageColorNormal
        self.backgroudImageColorHighlight = backgroudImageColorHighlight
    }
}

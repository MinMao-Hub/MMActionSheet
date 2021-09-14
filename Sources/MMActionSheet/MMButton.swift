//
//  DDButton.swift
//  swiftui
//
//  Created by 郭永红 on 2017/10/9.
//  Copyright © 2017年 keeponrunning. All rights reserved.
//

import UIKit

class MMButton: UIButton {
    /// item
    public var item: MMButtonItem? {
        willSet { updateButton(newValue) }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    private func updateButton(_ item: MMButtonItem?) {
        guard let newItem = item else { return }
        /// Button Title
        setTitle(newItem.title, for: .normal)
        /// Button Title Color
        setTitleColor(newItem.titleColor?.rawValue, for: .normal)
        /// Button Title Font
        titleLabel?.font = item?.titleFont
        /// BackgroudImage Color
        let noramlColor = newItem.backgroudImageColorNormal?.rawValue ?? MMTools.DefaultColor.normalColor
        let highlightColor = newItem.backgroudImageColorHighlight?.rawValue ?? MMTools.DefaultColor.highlightColor

        setBackgroundImage(MMTools.imageWithColor(color: noramlColor, size: bounds.size), for: .normal)
        setBackgroundImage(MMTools.imageWithColor(color: highlightColor, size: bounds.size), for: .highlighted)
    }
}

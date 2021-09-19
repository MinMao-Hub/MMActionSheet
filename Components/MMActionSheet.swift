//
//  MMActionSheet.swift
//  swiftui
//
//  Created by 郭永红 on 2017/10/9.
//  Copyright © 2017年 keeponrunning. All rights reserved.
//

import UIKit

public class MMActionSheet: UIView {
    /// MMSelectionClosure
    public typealias MMSelectionClosure = (_ item: MMButtonItem?) -> Void
    /// SelectionClosure
    public var selectionClosure: MMSelectionClosure?

    /// Parmeters
    private var title: MMTitleItem?
    private var buttons: [MMButtonItem] = []
    private var duration: Double?
    private var cancelButton: MMButtonItem?

    /// Constants
    private struct Constants {
        /// 按钮与按钮之间的分割线高度
        static let mmdivideLineHeight: CGFloat = 1
        /// 屏幕Bounds
        static let mmscreenBounds = UIScreen.main.bounds
        /// 屏幕大小
        static let mmscreenSize = UIScreen.main.bounds.size
        /// 屏幕宽度
        static let mmscreenWidth = mmscreenBounds.width
        /// 屏幕高度
        static let mmscreenHeight = mmscreenBounds.height
        /// button高度
        static let mmbuttonHeight: CGFloat = 48.0 * mmscreenBounds.width / 375
        /// 标题的高度
        static let mmtitleHeight: CGFloat = 40.0 * mmscreenBounds.width / 375
        /// 取消按钮与其他按钮之间的间距
        static let mmbtnPadding: CGFloat = 5 * mmscreenBounds.width / 375
        /// mmdefaultDuration
        static let mmdefaultDuration = 0.25
        /// sheet的最大高度
        static let mmmaxHeight = mmscreenBounds.height * 0.65
        /// 适配iphoneX
        static let paddng_bottom: CGFloat = MMTools.isIphoneX ? 34.0 : 0.0
    }

    /// ActionSheet
    private var actionSheetView: UIView = UIView()
    private var actionSheetHeight: CGFloat = 0

    public var actionSheetViewBackgroundColor: UIColor? = MMTools.DefaultColor.backgroundColor

    /// scrollView
    private var scrollView: UIScrollView = UIScrollView()

    public var buttonBackgroundColor: UIColor?

    /// Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 初始化
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - buttons: 按钮数组
    ///   - duration: 动画时长
    ///   - cancel: 是否需要取消按钮
    public convenience init(title: MMTitleItem?, buttons: [MMButtonItem], duration: Double?, cancelButton: MMButtonItem?) {
        /// 半透明背景
        self.init(frame: Constants.mmscreenBounds)
        self.title = title
        self.buttons = buttons

        self.duration = duration ?? Constants.mmdefaultDuration
        self.cancelButton = cancelButton

        /// 添加单击事件，隐藏sheet
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(singleTapDismiss))
        singleTap.delegate = self
        addGestureRecognizer(singleTap)

        /// actionSheet
        initActionSheet()
        /// 初始化UI
        initUI()
    }

    func initActionSheet() {
        let btnCount = buttons.count

        var tHeight: CGFloat = 0.0
        if title != nil {
            tHeight = Constants.mmtitleHeight
        }

        var cancelHeight: CGFloat = 0.0
        if cancelButton != nil {
            cancelHeight = Constants.mmbuttonHeight + Constants.mmbtnPadding
        }

        let contentHeight = CGFloat(btnCount) * Constants.mmbuttonHeight + CGFloat(btnCount) * Constants.mmdivideLineHeight
        let height = min(contentHeight, Constants.mmmaxHeight)

        scrollView.frame = CGRect(x: 0, y: tHeight, width: Constants.mmscreenWidth, height: height)
        actionSheetView.addSubview(scrollView)

        actionSheetHeight = tHeight + height + cancelHeight + Constants.paddng_bottom

        let aFrame: CGRect = CGRect(x: 0, y: Constants.mmscreenHeight, width: Constants.mmscreenWidth, height: actionSheetHeight)
        actionSheetView.frame = aFrame
        addSubview(actionSheetView)

        /// 根据内容高度计算动画时长
        duration = duration ?? (Constants.mmdefaultDuration * Double(actionSheetHeight / 216))
    }

    func initUI() {
        /// setTitleView
        setTitleView()
        /// setButtons
        setButtons()
        /// Cancel Button
        setCancelButton()
        /// setExtraView
        setExtraView()
    }

    /// Title
    private func setTitleView() {
        /// 标题不为空，则添加标题
        if title != nil {
            let titleFrame = CGRect(x: 0, y: 0, width: Constants.mmscreenWidth, height: Constants.mmtitleHeight)
            let titlelabel = UILabel(frame: titleFrame)
            titlelabel.text = title!.text
            titlelabel.textAlignment = title!.textAlignment!
            titlelabel.textColor = title!.textColor
            titlelabel.font = title!.textFont
            actionSheetView.addSubview(titlelabel)
        }
    }

    /// Buttons
    private func setButtons() {
        let contentHeight = CGFloat(buttons.count) * Constants.mmbuttonHeight + CGFloat(buttons.count) * Constants.mmdivideLineHeight
        let view = UIView(frame: CGRect(x: 0, y: 0, width: Constants.mmscreenWidth, height: contentHeight))
        view.clipsToBounds = true
        scrollView.addSubview(view)
        scrollView.contentSize = CGSize(width: Constants.mmscreenWidth, height: contentHeight)

        let buttonsCount = buttons.count
        for index in 0 ..< buttonsCount {
            let item = buttons[index]
            let origin_y = Constants.mmbuttonHeight * CGFloat(index) + Constants.mmdivideLineHeight * CGFloat(index)

            let button = MMButton(type: .custom)
            button.frame = CGRect(x: 0.0, y: origin_y, width: Constants.mmscreenWidth, height: Constants.mmbuttonHeight)
            /// Button Item
            button.item = item
            button.addTarget(self, action: #selector(actionClick), for: .touchUpInside)
            view.addSubview(button)
        }
    }

    /// ExtraView
    private func setExtraView() {
        guard MMTools.isIphoneX else { return }
        let frame = CGRect(x: 0, y: self.actionSheetView.bounds.size.height - Constants.paddng_bottom, width: Constants.mmscreenWidth, height: Constants.paddng_bottom)
        let extraView = UIView()
        extraView.frame = frame
        if cancelButton != nil {
            extraView.backgroundColor = cancelButton?.backgroudImageColorNormal?.rawValue
        } else {
            let bgColor = buttons.first?.backgroudImageColorNormal?.rawValue
            extraView.backgroundColor = bgColor
        }
        self.actionSheetView.addSubview(extraView)
    }

    /// Cancel Button
    private func setCancelButton() {
        /// 如果取消为ture则添加取消按钮
        if cancelButton != nil {
            let button = MMButton(type: .custom)
            button.frame = CGRect(x: 0, y: actionSheetView.bounds.size.height - Constants.mmbuttonHeight - Constants.paddng_bottom, width: Constants.mmscreenWidth, height: Constants.mmbuttonHeight)
            button.item = cancelButton
            button.addTarget(self, action: #selector(actionClick), for: .touchUpInside)
            actionSheetView.addSubview(button)
        }
    }

    /// 修改样式
    override public func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        actionSheetView.backgroundColor = actionSheetViewBackgroundColor
    }
}

//MARK: Event
extension MMActionSheet {
    /// items action
    @objc func actionClick(button: MMButton) {
        dismiss()
        guard let item = button.item else { return }
        /// Callback
        selectionClosure?(item)
    }

    //tap action
    @objc func singleTapDismiss() {
        dismiss()
        /// Callback
        selectionClosure?(nil)
    }
}

//MARK: present, dismiss
extension MMActionSheet {
    /// 显示
    public func present() {
        UIView.animate(withDuration: 0.1, animations: { [self] in
            if #available(iOS 13.0, *) {
                if let keyWindow = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first {
                    keyWindow.addSubview(self)
                }
            } else {
                UIApplication.shared.keyWindow?.addSubview(self)
            }
            /// backgroundColor
            self.actionSheetView.backgroundColor = actionSheetViewBackgroundColor
        }) { (_: Bool) in
            UIView.animate(withDuration: self.duration!) {
                self.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.3)
                var tempFrame = self.actionSheetView.frame
                tempFrame.origin.y = Constants.mmscreenHeight - tempFrame.size.height
                self.actionSheetView.frame = tempFrame
            }
        }
    }

    /// 隐藏
    func dismiss() {
        UIView.animate(withDuration: duration!, animations: {
            self.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
            var tempFrame = self.actionSheetView.frame
            tempFrame.origin.y = Constants.mmscreenHeight
            self.actionSheetView.frame = tempFrame
        }) { (_: Bool) in
            self.removeFromSuperview()
        }
    }
}


// MARK: - UIGestureRecognizerDelegate
extension MMActionSheet: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard touch.view == actionSheetView else { return true }
        return false
    }
}

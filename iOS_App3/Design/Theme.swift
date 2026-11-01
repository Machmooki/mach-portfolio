//
//  Theme.swift
//  iOS_App3
//
//  Created by Mach Suwanpatikorn on 31/10/2569 BE.
//

import UIKit

enum Theme {
    static let white = UIColor.white         
    static let lightGray = UIColor(red: 0.969, green: 0.969, blue: 0.969, alpha: 1)
    static let black = UIColor(red: 0.090, green: 0.090, blue: 0.090, alpha: 1)
    static let gray = UIColor(red: 0.467, green: 0.467, blue: 0.467, alpha: 1)
    static let border = UIColor(red: 0.910, green: 0.910, blue: 0.910, alpha: 1)

    static func styleNavigationBar(of viewController: UIViewController) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = white
        appearance.shadowColor = border
        appearance.titleTextAttributes = [.foregroundColor: black, .font: UIFont.systemFont(ofSize: 17, weight: .semibold)]
        appearance.largeTitleTextAttributes = [.foregroundColor: black, .font: UIFont.systemFont(ofSize: 32, weight: .bold)]

        let item = viewController.navigationItem
        item.standardAppearance = appearance
        item.scrollEdgeAppearance = appearance
        item.compactAppearance = appearance
        item.backButtonDisplayMode = .minimal
    }
}

extension UILabel {
    func setText(_ text: String, lineSpacing: CGFloat = 1.3) {
        let style = NSMutableParagraphStyle()
        style.lineHeightMultiple = lineSpacing
        style.alignment = textAlignment
        attributedText = NSAttributedString(string: text, attributes: [
            .paragraphStyle: style,
            .font: font!,
            .foregroundColor: textColor!
        ])
    }
}

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            layer.cornerCurve = .continuous
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get { layer.borderWidth }
        set { layer.borderWidth = newValue }
    }

    @IBInspectable var borderColor: UIColor? {
        get { layer.borderColor.map { UIColor(cgColor: $0) } }
        set { layer.borderColor = newValue?.cgColor }
    }
}

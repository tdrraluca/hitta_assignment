//
//  Style.swift
//  HittaTechAssignment
//
//  Created by Raluca Toadere on 01/12/2018.
//  Copyright © 2018 Raluca Toadere. All rights reserved.
//

import UIKit

struct ColorPalette {
    static let fakeBlack = UIColor(hexRed: 0x33, hexGreen: 0x33, hexBlue: 0x33, alpha: 1)
    static let white = UIColor(hexRed: 0xff, hexGreen: 0xff, hexBlue: 0xff, alpha: 1)
    static let yellow = UIColor(hexRed: 0xfe, hexGreen: 0xcd, hexBlue: 0x01, alpha: 1)
    static let linkBlue = UIColor(hexRed: 0x03, hexGreen: 0x9b, hexBlue: 0xef, alpha: 1)
    static let mediumGray = UIColor(hexRed: 0x9b, hexGreen: 0x9b, hexBlue: 0x9b, alpha: 1)
    static let separatorGray = UIColor(hexRed: 0xef, hexGreen: 0xef, hexBlue: 0xe4, alpha: 1)
    static let navigationBlue = UIColor(hexRed: 0x34, hexGreen: 0xaf, hexBlue: 0xf4, alpha: 1)
}

class LabelStyles {
    static func applyHeaderStyle(_ label: UILabel) {
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        label.textColor = ColorPalette.fakeBlack
    }

    static func applyNoteStyle(_ label: UILabel) {
        label.font = UIFont(name: "Helvetica", size: 13)
        label.textColor = ColorPalette.mediumGray
    }

    static func applyBoxHighlightedStyle(_ label: UILabel) {
        label.font = UIFont(name: "Helvetica-Bold", size: 16)
        label.textColor = ColorPalette.fakeBlack

        label.backgroundColor = ColorPalette.yellow
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.textAlignment = .center
    }

    static func applyElementBoldTitleStyle(_ label: UILabel) {
        label.font = UIFont(name: "Helvetica-Bold", size: 16)
        label.textColor = ColorPalette.fakeBlack
    }

    static func applyElementMediumTitleStyle(_ label: UILabel) {
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        label.textColor = ColorPalette.fakeBlack
    }

    static func applyTextBlockStyle(_ label: UILabel) {
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica", size: 16)
        label.textColor = ColorPalette.fakeBlack
    }

    static func applyPlaceholderStyle(_ label: UILabel) {
        label.font = UIFont(name: "Helvetica", size: 17)
        label.textColor = ColorPalette.mediumGray
    }
}

class ButtonStyles {
    static func applyLinkStyle(_ button: UIButton) {
        button.setTitleColor(ColorPalette.linkBlue, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 16)
    }

    static func applyEmphasisedLinkStyle(_ button: UIButton) {
        button.setTitleColor(ColorPalette.linkBlue, for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
    }
}

class TextFieldStyles {
    static func applyHittaStyle(_ textField: UITextField) {
        textField.borderStyle = .none
        textField.font = UIFont(name: "Helvetica", size: 17)
        textField.textColor = ColorPalette.fakeBlack
    }
}

class TextViewStyles {
    static func applyHittaStyle(_ textView: UITextView) {
        textView.font = UIFont(name: "Helvetica", size: 17)
        textView.textColor = ColorPalette.fakeBlack
    }
}

class AttributedStrings {
    static func placeholderAttributedString(value: String) -> NSAttributedString {

        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: ColorPalette.mediumGray,
            .font: UIFont(name: "Helvetica", size: 17)!
        ]
        let attributedString = NSAttributedString(string: value, attributes: attributes)
        return attributedString
    }
}

//
//  String+Extension.swift
//  NASAImagesCore
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

import NASAImagesUI
import UIKit

public extension String {
    func htmlToAttributedString(
        color: UIColor = Color.standardText,
        font: UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
    ) -> NSAttributedString {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            let text = try NSMutableAttributedString(
                data: data,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ],
                documentAttributes: nil
            )
            text.addAttribute(.foregroundColor, value: color, range: NSRange(location: 0, length: text.length))
            text.addAttribute(.font, value: font, range: NSRange(location: 0, length: text.length))
            return text
        } catch {
            return NSAttributedString(string: self)
        }
    }
}

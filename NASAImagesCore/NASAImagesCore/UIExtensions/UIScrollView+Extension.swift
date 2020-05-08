//
//  UIScrollView+Extension.swift
//  NASAImagesCore
//
//  Created by Robert Dresler on 08/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

import UIKit

public extension UIScrollView {
    func scrollToTop(animated: Bool) {
        let offset = CGPoint(x: -adjustedContentInset.left, y: -adjustedContentInset.top)
        setContentOffset(offset, animated: animated)
    }
}

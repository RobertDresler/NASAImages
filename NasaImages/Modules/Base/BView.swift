//
//  BView.swift
//  NASAImages
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

import NASAImagesCore
import UIKit

class BView: UIView {

    required init() {
        super.init(frame: .zero)
        callSetups()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension BView: ViewSetupable {
    func setupView() {}
    func addSubviews() {}
    func setupSubviews() {}
    func setupConstraints() {}
}

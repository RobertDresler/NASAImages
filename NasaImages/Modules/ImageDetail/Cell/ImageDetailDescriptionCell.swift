//
//  ImageDetailDescriptionCell.swift
//  NASAImages
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

import NASAImagesCore
import NASAImagesUI
import UIKit

final class ImageDetailDescriptionCell: BCell, Configurable, DynamicHeightView {

    static var estimatedHeight: CGFloat = 256

    private let textView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.dataDetectorTypes = .all
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 0
        textView.backgroundColor = Color.clear
        return textView
    }()

    override func setupView() {
        super.setupView()
        backgroundColor = Color.cellBackground
    }

    override func addSubviews() {
        super.addSubviews()
        contentView.addSubviews(textView)
    }

    override func setupConstraints() {
        super.setupConstraints()
        textView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Padding.huge)
            make.leading.trailing.equalTo(readableContentGuide)
        }
    }

    func configure(for viewModel: ImageDetailDescriptionCellViewModel) {
        textView.attributedText = viewModel.description
    }

}

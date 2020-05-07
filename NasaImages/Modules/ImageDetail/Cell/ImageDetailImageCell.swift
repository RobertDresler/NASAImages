//
//  ImageDetailImageCell.swift
//  NASAImages
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

import Kingfisher
import NASAImagesCore
import NASAImagesUI
import UIKit

final class ImageDetailImageCell: BCell, Configurable, DynamicHeightView {

    static var estimatedHeight: CGFloat = 256

    private let originalImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = Color.imageViewBackground
        return imageView
    }()

    override func setupView() {
        super.setupView()
        backgroundColor = Color.cellBackground
    }

    override func addSubviews() {
        super.addSubviews()
        contentView.addSubview(originalImageView)
    }

    override func setupConstraints() {
        super.setupConstraints()
        originalImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Padding.large)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(originalImageView.snp.width).dividedBy(16.0/9.0)
        }
    }

    func configure(for viewModel: ImageDetailImageCellViewModel) {
        originalImageView.kf.setImage(with: viewModel.originalImageUrl, placeholder: viewModel.thumbnailImage)
        originalImageView.snp.remakeConstraints { make in
            make.top.equalToSuperview().inset(Padding.large)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(originalImageView.snp.width).dividedBy(viewModel.imageRatio)
        }
    }

}

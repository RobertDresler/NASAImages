//
//  ImageDetailCell.swift
//  NASAImages
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

import Kingfisher
import NASAImagesCore
import NASAImagesUI
import UIKit

final class ImageCell: BCell, Configurable, DynamicHeightView {

    static var estimatedHeight: CGFloat = 128
    private static let wrapperViewCornerRadius = CornerRadiusSize.large

    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = wrapperViewCornerRadius
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imageView.clipsToBounds = true
        imageView.backgroundColor = Color.imageViewBackground
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = Color.standardText
        return label
    }()

    private lazy var contentStackView = [
        titleLabel
    ].stacked(.vertical, spacing: .xsmall)

    private let wrapperView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.cellBackground
        view.layer.cornerRadius = wrapperViewCornerRadius
        view.addShadow(color: Color.shadow, opacity: 0.2, radius: 12)
        return view
    }()

    private lazy var highlightCoverLayer: CALayer = {
        let layer = CALayer()
        layer.frame = wrapperView.bounds
        layer.backgroundColor = Color.higlightCoverLayer.cgColor
        layer.opacity = 0
        layer.cornerRadius = ImageCell.wrapperViewCornerRadius
        wrapperView.layer.addSublayer(layer)
        return layer
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        highlightCoverLayer.frame = wrapperView.bounds
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        highlightCoverLayer.opacity = 0
    }

    override func setupView() {
        super.setupView()
        backgroundColor = NASAImagesUI.Color.clear
    }

    override func addSubviews() {
        super.addSubviews()
        contentView.addSubviews(wrapperView)
        wrapperView.addSubviews(thumbnailImageView, contentStackView)
    }

    override func setupSubviews() {
        super.setupSubviews()
        contentView.backgroundColor = NASAImagesUI.Color.clear
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        highlightCoverLayer.opacity = isHighlighted ? 0.3 : 0
    }

    override func setupConstraints() {
        super.setupConstraints()
        wrapperView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Padding.small)
            make.leading.trailing.equalToSuperview()
            make.leading.trailing.equalTo(readableContentGuide)
        }
        thumbnailImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(thumbnailImageView.snp.width).multipliedBy(9.0/16.0)
        }
        contentStackView.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(Padding.large)
            make.leading.trailing.bottom.equalToSuperview().inset(Padding.large)
        }
    }

    func configure(for viewModel: ImageCellViewModel) {
        thumbnailImageView.kf.setImage(with: viewModel.thumbnailImageUrl)
        titleLabel.text = viewModel.title
    }

}

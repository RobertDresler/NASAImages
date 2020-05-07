//
//  WorkoutCell.swift
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

    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
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
        thumbnailImageView, titleLabel
    ].stacked(.vertical, spacing: .xsmall)

    private let wrapperView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.cellBackground
        view.layer.cornerRadius = CornerRadiusSize.large
        view.addShadow(color: Color.shadow, opacity: 0.15, radius: 12)
        return view
    }()

    override func setupView() {
        super.setupView()
        backgroundColor = NASAImagesUI.Color.clear
    }

    override func addSubviews() {
        super.addSubviews()
        contentView.addSubviews(wrapperView)
        wrapperView.addSubviews(contentStackView)
    }

    override func setupSubviews() {
        super.setupSubviews()
        contentView.backgroundColor = NASAImagesUI.Color.clear
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        wrapperView.backgroundColor = isHighlighted ? Color.cellHighlightedBackground : Color.cellBackground
    }

    override func setupConstraints() {
        super.setupConstraints()
        wrapperView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Padding.small)
            make.leading.trailing.equalTo(readableContentGuide)
        }
        contentStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Padding.large)
        }
        thumbnailImageView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(thumbnailImageView.snp.width).dividedBy(9/16)
        }
    }

    func configure(for viewModel: ImageCellViewModel) {
        thumbnailImageView.kf.setImage(with: viewModel.thumbnailImageUrl)
        titleLabel.text = viewModel.title
    }

}

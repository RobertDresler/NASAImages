//
//  ImageDetailAttributeCell.swift
//  NASAImages
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

import NASAImagesCore
import NASAImagesUI
import UIKit

final class ImageDetailAttributeCell: BCell, Configurable, DynamicHeightView {

    static var estimatedHeight: CGFloat = 96

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        callSetups()
        selectionStyle = .none
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupView() {
        super.setupView()
        backgroundColor = Color.cellBackground
    }

    override func setupSubviews() {
        super.setupSubviews()
        textLabel?.font = .preferredFont(forTextStyle: .caption1)
        textLabel?.numberOfLines = 0
        detailTextLabel?.numberOfLines = 0
    }

    func configure(for viewModel: ImageDetailAttributeCellViewModel) {
        textLabel?.text = viewModel.title
        detailTextLabel?.text = viewModel.description
    }

}

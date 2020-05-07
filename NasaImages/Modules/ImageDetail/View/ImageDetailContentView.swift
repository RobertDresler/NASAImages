//
//  ImageDetailContentView.swift
//  NASAImages
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

import NASAImagesUI
import SnapKit
import UIKit

final class ImageDetailContentView: BView {

    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.allowsSelection = true
        tableView.rowHeight = UITableView.automaticDimension
        tableView.contentInset.bottom = Padding.xxhuge
        tableView.cellLayoutMarginsFollowReadableWidth = true
        tableView.backgroundColor = Color.cellBackground
        return tableView
    }()

    override func setupView() {
        super.setupView()
        backgroundColor = Color.cellBackground
    }

    override func addSubviews() {
        super.addSubviews()
        addSubviews(tableView)
    }

    override func setupConstraints() {
        super.setupConstraints()
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}

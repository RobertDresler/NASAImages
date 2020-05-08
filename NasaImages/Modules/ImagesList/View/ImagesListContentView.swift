//
//  ImagesListContentView.swift
//  NASAImages
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

import NASAImagesUI
import SnapKit
import UIKit

final class ImagesListContentView: BView {

    var skeletonLoadingViewIsVisible: Bool {
        get {
            return skeletonLoadingView.isHidden == false
        }
        set {
            if newValue {
                DispatchQueue.main.async {
                    self.tableView.refreshControl = nil
                    self.tableView.scrollToTop(animated: false)
                    self.skeletonLoadingView.setNeedsLayout()
                    self.skeletonLoadingView.layoutIfNeeded()
                }
            }
            skeletonLoadingView.isHidden = !newValue
        }
    }

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.clipsToBounds = false
        tableView.contentInset.bottom = Padding.xxhuge
        tableView.backgroundColor = Color.background
        tableView.cellLayoutMarginsFollowReadableWidth = true
        return tableView
    }()

    let skeletonLoadingView: SkeletonLoadingView = {
        let view = SkeletonLoadingView()
        view.backgroundColor = Color.background
        view.gradientColors = (Color.skeletonViewGradientFirst, Color.skeletonViewGradientSecond)
        view.isHidden = true
        return view
    }()

    override func setupView() {
        super.setupView()
        backgroundColor = Color.background
        skeletonLoadingView.baseView = self
    }

    override func addSubviews() {
        super.addSubviews()
        addSubviews(tableView, skeletonLoadingView)
    }

    override func setupConstraints() {
        super.setupConstraints()
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        skeletonLoadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        skeletonLoadingView.backgroundColor = Color.background
        skeletonLoadingView.gradientColors = (Color.skeletonViewGradientFirst, Color.skeletonViewGradientSecond)
    }

}

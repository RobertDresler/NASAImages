//
//  ImageDetailViewController.swift
//  NASAImages
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

import NASAImagesCore
import Toast_Swift
import UIKit

final class ImageDetailViewController: BViewController<ImageDetailViewModel, ImageDetailContentView>,
    ImageDetailView {

    weak var delegate: ImageDetailViewDelegate?

    private var tableView: UITableView {
        return contentView.tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addCloseButton()
        setupTableView()
    }

    private func setupTableView() {
        tableView.register(
            ImageDetailImageCell.self,
            ImageDetailDescriptionCell.self,
            ImageDetailAttributeCell.self
        )
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.onDataChange = { [weak self] in
            self?.tableView.reloadData()
        }
    }

    private func addCloseButton() {
        let item: UIBarButtonItem = {
            if #available(iOS 13.0, *) {
                return UIBarButtonItem(
                    barButtonSystemItem: .close,
                    target: self,
                    action: #selector(closeBarButtonItemPressed)
                )
            } else {
                return UIBarButtonItem(
                    title: R.string.localizable.close(),
                    style: .plain,
                    target: self,
                    action: #selector(closeBarButtonItemPressed)
                )
            }
        }()
        navigationItem.leftBarButtonItem = item
    }

    @objc private func closeBarButtonItemPressed() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        delegate?.imageDetailViewDidTapCancelButton()
    }

}

extension ImageDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = viewModel.dataSource[safe: indexPath.row] else {
            fatalError("Bad manipulating with data source.")
        }

        switch item {
        case .image(let viewModel):
            let cell: ImageDetailImageCell = tableView.dequeueReusableCell(for: indexPath)
            return cell.configured(for: viewModel)
        case .description(let viewModel):
            let cell: ImageDetailDescriptionCell = tableView.dequeueReusableCell(for: indexPath)
            return cell.configured(for: viewModel)
        case .attribute(let viewModel):
            let cell: ImageDetailAttributeCell = tableView.dequeueReusableCell(for: indexPath)
            return cell.configured(for: viewModel)
        }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let item = viewModel.dataSource[safe: indexPath.row] else {
            fatalError("Bad manipulating with data source.")
        }
        switch item {
        case .image:
            return ImageDetailImageCell.estimatedHeight
        case .description:
            return ImageDetailDescriptionCell.estimatedHeight
        case .attribute:
            return ImageDetailAttributeCell.estimatedHeight
        }
    }
}

//
//  ImagesListViewController.swift
//  NASAImages
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

import NASAImagesCore
import Toast_Swift
import UIKit

final class ImagesListViewController: BViewController<ImagesListViewModel, ImagesListContentView>,
    ImagesListView {

    weak var delegate: ImagesListViewDelegate?

    private let placeholderView = TableViewPlaceholderView()

    private var tableView: UITableView {
        return contentView.tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchController()
        viewModel.loadDataIfNeeded()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contentView.skeletonLoadingView.layoutSubviews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contentView.skeletonLoadingViewIsVisible = contentView.skeletonLoadingViewIsVisible
    }

    override func bindViewModel() {
        super.bindViewModel()
        viewModel.placeholderViewModel.bind { [weak self] viewModel in
            if let viewModel = viewModel {
                self?.placeholderView.configure(for: viewModel)
                self?.tableView.backgroundView = self?.placeholderView
            } else {
                self?.tableView.backgroundView = nil
            }
        }.disposed(by: bag)

        bindSkeletonLoadingViewVisibility()
    }

    private func bindSkeletonLoadingViewVisibility() {
        viewModel.state.bind { [weak self] state in
            guard let self = self else { return }
            DispatchQueue.main.async {
                let isLoading = state == .loading
                let areDummyDataVisible = self.viewModel.areDummyDataVisible
                self.contentView.skeletonLoadingViewIsVisible = isLoading && areDummyDataVisible
            }
        }.disposed(by: bag)
    }

    private func setupTableView() {
        tableView.register(ImageCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        addRefreshControl()
        tableView.estimatedRowHeight = ImageCell.estimatedHeight
        viewModel.onDataChange = { [weak self] in
            self?.tableView.reloadData()
        }
    }

    private func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }

    private func addRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlChanged), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    @objc private func refreshControlChanged() {
        viewModel.loadDataIfNeeded()
    }

}

extension ImagesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = self.viewModel.dataSource[safe: indexPath.row]?.viewModel else {
            fatalError("Bad manipulating with data source.")
        }
        let cell: ImageCell = tableView.dequeueReusableCell(for: indexPath)
        return cell.configured(for: viewModel)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let image = self.viewModel.dataSource[safe: indexPath.row]?.model else {
            return assertionFailure("Bad manipulating with data source.")
        }
        delegate?.didSelectImage(image)
    }
}

extension ImagesListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchQuery.accept(searchText)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.text = viewModel.searchQuery.value
    }
}

//
//  ImagesListViewModel.swift
//  NASAImages
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

import NASAImagesCore
import NASAImagesNetwork
import RxCocoa
import RxSwift

final class ImagesListViewModel: BViewModel {

    var title: String {
        return R.string.localizable.imagesListTitle()
    }

    enum State: Equatable {
        case initial
        case loading
        case loaded
        case errorReceived(String)
    }

    typealias DataSourceItem = (model: NASAImage, viewModel: ImageCellViewModel)

    let bag = DisposeBag()
    let state = BehaviorRelay<State>(value: .initial)
    var dataSource = [DataSourceItem]()
    let isActivityIndicatorLoading = BehaviorRelay<Bool>(value: false)
    let placeholderViewModel = BehaviorRelay<TableViewPlaceholderViewModel?>(value: nil)
    let searchQuery = BehaviorRelay<String>(value: "")

    private let searchRequester: SearchRequestable

    init(searchRequester: SearchRequestable) {
        self.searchRequester = searchRequester
        setupBinding()
    }

    private func setupBinding() {
        state.map { state -> Bool in state == .loading }.bind(to: isActivityIndicatorLoading).disposed(by: bag)

        state
            .map { [weak self] state -> TableViewPlaceholderViewModel? in
                if case let .errorReceived(message) = state {
                    return TableViewPlaceholderViewModel(
                        title: R.string.localizable.errorImagesListPlaceholderTitle(),
                        description: message
                    )
                } else if state == .loaded && self?.dataSource.isEmpty == true {
                    return TableViewPlaceholderViewModel(
                        title: R.string.localizable.emptyImagesListPlaceholderTitle(),
                        description: R.string.localizable.emptyImagesListPlaceholderDescription()
                    )
                } else {
                    return nil
                }
            }
            .bind(to: placeholderViewModel)
            .disposed(by: bag)

        searchQuery
            .skip(1)
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind { [weak self] _ in self?.loadData() }
            .disposed(by: bag)
    }

    func loadDataIfNeeded() {
        guard state.value != .loading else { return }
        loadData()
    }

    func loadData() {
        state.accept(.loading)
        searchRequester.getImages(for: searchQuery.value).subscribe(
            onSuccess: { [weak self] in self?.process(with: $0) },
            onError: { [weak self] in self?.process(with: $0) }
        ).disposed(by: bag)
    }

    private func process(with images: [NASAImage]) {
        dataSource = images.map { ($0, viewModel(for: $0)) }
        state.accept(.loaded)
    }

    private func process(with error: Error) {
        state.accept(
            .errorReceived((error as? LocalizedError)?.errorDescription ?? R.string.localizable.unexpectedErrorOccurred())
        )
    }

    private func viewModel(for image: NASAImage) -> ImageCellViewModel {
        return ImageCellViewModel(thumbnailImageUrl: image.thumbnailImageUrl, title: image.title)
    }

}

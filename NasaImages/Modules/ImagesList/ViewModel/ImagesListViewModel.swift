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
        case emptyData
        case errorReceived(String)
    }

    typealias DataSourceItem = (model: NASAImage, viewModel: ImageCellViewModel)

    let bag = DisposeBag()
    let state = BehaviorRelay<State>(value: .initial)
    var dataSource = [DataSourceItem]()
    var onDataChange: () -> Void = {}
    var areDummyDataVisible = false
    let isActivityIndicatorLoading = BehaviorRelay<Bool>(value: false)
    let placeholderViewModel = BehaviorRelay<TableViewPlaceholderViewModel?>(value: nil)
    let searchQuery = BehaviorRelay<String>(value: "")

    private let searchRequester: SearchRequestable

    init(searchRequester: SearchRequestable) {
        self.searchRequester = searchRequester
        setupBinding()
    }

    private func setupBinding() {
        state
            .map { state -> TableViewPlaceholderViewModel? in
                if case let .errorReceived(message) = state {
                    return TableViewPlaceholderViewModel(
                        title: R.string.localizable.errorImagesListPlaceholderTitle(),
                        description: message
                    )
                } else if state == .emptyData {
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
        showDummyContent()
        state.accept(.loading)
        searchRequester.getImages(for: searchQuery.value).subscribe(
            onSuccess: { [weak self] in self?.process(with: $0) },
            onError: { [weak self] in self?.process(with: $0) }
        ).disposed(by: bag)
    }

    private func process(with images: [NASAImage]) {
        areDummyDataVisible = false
        dataSource = images.map { ($0, ImagesListViewModel.viewModel(for: $0)) }
        onDataChange()
        state.accept(dataSource.isEmpty ? .emptyData : .loaded)
    }

    private func process(with error: Error) {
        dataSource = []
        onDataChange()
        state.accept(
            .errorReceived(
                (error as? LocalizedError)?.errorDescription ?? R.string.localizable.unexpectedErrorOccurred()
            )
        )
    }

    private static func viewModel(for image: NASAImage) -> ImageCellViewModel {
        return ImageCellViewModel(thumbnailImageUrl: image.thumbnailImageUrl, title: image.title)
    }

}

extension ImagesListViewModel: DummyContentDisplaying {

    func showDummyContent() {
        areDummyDataVisible = true
        dataSource = ImagesListViewModel.dummyContent
        state.accept(.loaded)
        onDataChange()
    }

    func removeDummyContent() {
        areDummyDataVisible = false
        dataSource.removeAll()
        onDataChange()
    }

    private static let dummyContent = Array(
        repeating: NASAImage(
            title: "dummyContent",
            description: nil,
            center: "",
            dateCreated: Date(),
            photographer: nil,
            secondaryCreator: nil,
            thumbnailImageUrl: nil,
            originalImageUrl: nil
        ),
        count: 10
    ).map { ($0, viewModel(for: $0)) }
}

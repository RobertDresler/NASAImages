//
//  ImagesListViewModel.swift
//  NASAImages
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

import NASAImagesCore
import RxCocoa
import RxSwift

// TODO: -RD- search
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

    init() {
        setupBinding()
    }

    private func setupBinding() {
        state.map { state -> Bool in state == .loading }.bind(to: isActivityIndicatorLoading).disposed(by: bag)

        state.map { [weak self] state -> TableViewPlaceholderViewModel? in
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
    }

    func loadData() {
        guard state.value != .loading else { return }
        state.accept(.loading)
        // TODO: -RD- load data from API
        // TODO: -RD- remove test data
        dataSource = [
            NASAImage(
                title: "Obr fd",
                description: nil, center: "",
                dateCreated: Date(),
                photographer: nil,
                secondaryCreator: nil,
                thumbnailImageUrl: URL(string: "https://images-assets.nasa.gov/image/PIA12235/PIA12235~thumb.jpg"),
                originalImageUrl: URL(string: "https://images-assets.nasa.gov/image/PIA12235/PIA12235~orig.jpg")
            ),
            NASAImage(
                title: "Obr fd",
                description: nil, center: "",
                dateCreated: Date(),
                photographer: nil,
                secondaryCreator: nil,
                thumbnailImageUrl: URL(string: "https://images-assets.nasa.gov/image/PIA12235/PIA12235~thumb.jpg"),
                originalImageUrl: URL(string: "https://images-assets.nasa.gov/image/PIA12235/PIA12235~orig.jpg")
            ),
            NASAImage(
                title: "Obr fd",
                description: nil, center: "",
                dateCreated: Date(),
                photographer: nil,
                secondaryCreator: nil,
                thumbnailImageUrl: URL(string: "https://images-assets.nasa.gov/image/PIA12235/PIA12235~thumb.jpg"),
                originalImageUrl: URL(string: "https://images-assets.nasa.gov/image/PIA12235/PIA12235~orig.jpg")
            )
        ].map { ($0, viewModel(for: $0)) }
        state.accept(.loaded)
    }

    private func viewModel(for image: NASAImage) -> ImageCellViewModel {
        return ImageCellViewModel(thumbnailImageUrl: image.thumbnailImageUrl, title: image.title)
    }

    private func process(with error: Error) {
        state.accept(.errorReceived((error as? LocalizedError)?.errorDescription ?? "Error"))
    }

}

//
//  ImageDetailViewModel.swift
//  NASAImages
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

import Kingfisher
import NASAImagesCore
import RxSwift

final class ImageDetailViewModel: BViewModel {

    var title: String {
        return image.title
    }

    var dataSource = [ImageDetailDataSourceItem]()
    private let image: NASAImage
    private let kingfisherManager: KingfisherManager

    init(image: NASAImage, kingfisherManager: KingfisherManager) {
        self.image = image
        self.kingfisherManager = kingfisherManager
        loadData()
    }

    private func loadData() {
        guard let url = image.thumbnailImageUrl else { return }
        kingfisherManager.retrieveImage(with: url) { [weak self] result in
            self?.process(with: try? result.get().image)
        }
    }

    private func process(with cachedImage: UIImage?) {
        var newDataSource = [ImageDetailDataSourceItem]()

        newDataSource.append(.image(
            ImageDetailImageCellViewModel(
                thumbnailImage: cachedImage,
                originalImageUrl: image.originalImageUrl,
                imageRatio: (cachedImage?.size.width ?? 0) / (cachedImage?.size.height ?? 0)
            )
        ))

        if let description = image.description {
            newDataSource.append(.description(
                // NOTE: Some descriptions contains html tags
                ImageDetailDescriptionCellViewModel(description: description.htmlToAttributedString())
            ))
        }

        newDataSource.append(.attribute(ImageDetailAttributeCellViewModel(
            title: R.string.localizable.imageDetailCenterAttributeTitle(),
            description: image.center
        )))

        newDataSource.append(.attribute(ImageDetailAttributeCellViewModel(
            title: R.string.localizable.imageDetailDateCreatedAttributeTitle(),
            description: DateFormatter.dMyyyy.string(from: image.dateCreated)
        )))

        if let photographer = image.photographer {
            newDataSource.append(.attribute(ImageDetailAttributeCellViewModel(
                title: R.string.localizable.imageDetailPhotographerAttributeTitle(),
                description: photographer
            )))
        }

        if let secondaryCreator = image.secondaryCreator {
            newDataSource.append(.attribute(ImageDetailAttributeCellViewModel(
                title: R.string.localizable.imageDetailSecondaryCreatorAttributeTitle(),
                description: secondaryCreator
            )))
        }

        dataSource = newDataSource
    }

}

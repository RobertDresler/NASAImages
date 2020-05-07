//
//  ImageDetailViewModel.swift
//  NASAImages
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

import NASAImagesCore
import RxSwift

final class ImageDetailViewModel: BViewModel {

    var title: String {
        return image.title
    }

    var dataSource = [ImageDetailDataSourceItem]()
    private let image: NASAImage

    init(image: NASAImage) {
        self.image = image
        loadData()
    }

    private func loadData() {
        var newDataSource = [ImageDetailDataSourceItem]()

        newDataSource.append(.image(ImageDetailImageCellViewModel(originalImageUrl: image.originalImageUrl)))

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

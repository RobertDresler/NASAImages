//
//  NASAImage.swift
//  NASAImagesCore
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

public struct NASAImage {

    public let title: String
    public let description: String?
    public let center: String
    public let dateCreated: Date
    public let photographer: String?
    public let secondaryCreator: String?
    public let thumbnailImageUrl: URL?
    public let originalImageUrl: URL?

    public init(
        title: String,
        description: String?,
        center: String,
        dateCreated: Date,
        photographer: String?,
        secondaryCreator: String?,
        thumbnailImageUrl: URL?,
        originalImageUrl: URL?
    ) {
        self.title = title
        self.description = description
        self.center = center
        self.dateCreated = dateCreated
        self.photographer = photographer
        self.secondaryCreator = secondaryCreator
        self.thumbnailImageUrl = thumbnailImageUrl
        self.originalImageUrl = originalImageUrl
    }

}

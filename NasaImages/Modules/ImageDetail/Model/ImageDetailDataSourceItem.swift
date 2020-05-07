//
//  ImageDetailDataSourceItem.swift
//  NASAImages
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

enum ImageDetailDataSourceItem {
    case image(ImageDetailImageCellViewModel)
    case description(ImageDetailDescriptionCellViewModel)
    case attribute(ImageDetailAttributeCellViewModel)
}

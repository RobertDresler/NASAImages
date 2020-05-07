//
//  SearchRequestable.swift
//  NASAImagesNetwork
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

import NASAImagesCore
import RxSwift

public protocol SearchRequestable {
    func getImages(for searchQuery: String) -> Single<[NASAImage]>
}

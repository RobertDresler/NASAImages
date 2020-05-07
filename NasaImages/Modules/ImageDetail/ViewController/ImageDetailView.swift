//
//  ImageDetailView.swift
//  NASAImages
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

import NASAImagesCore

protocol ImageDetailViewDelegate: class {
    func imageDetailViewDidTapCancelButton()
}

protocol ImageDetailView: BaseView {
    var delegate: ImageDetailViewDelegate? { get set }
}

//
//  BViewModel.swift
//  NASAImages
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

import RxSwift

protocol BViewModel: class {
    var bag: DisposeBag { get }
    var title: String { get }
}

extension BViewModel {
    var bag: DisposeBag {
        fatalError("Should be declared in class.")
    }

    var title: String {
        return ""
    }
}

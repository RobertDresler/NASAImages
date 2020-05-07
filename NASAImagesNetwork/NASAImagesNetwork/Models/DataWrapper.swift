//
//  DataWrapper.swift
//  NASAImages
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

struct DataWrapper<T: Decodable>: Decodable {
    let data: T
}

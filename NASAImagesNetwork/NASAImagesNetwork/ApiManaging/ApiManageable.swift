//
//  ApiManageable.swift
//  NASAImagesNetwork
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

import Alamofire
import NASAImagesCore
import RxSwift

public protocol ApiManageable {
    func request<T: Decodable>(
        _ request: Request,
        decoderSetup: @escaping (JSONDecoder) -> Void
    ) -> Single<T>
}

extension ApiManageable {
    func request<T: Decodable>(
        _ request: Request,
        decoderSetup: @escaping (JSONDecoder) -> Void = { _ in }
    ) -> Single<T> {
        return self.request(request, decoderSetup: decoderSetup)
    }
}

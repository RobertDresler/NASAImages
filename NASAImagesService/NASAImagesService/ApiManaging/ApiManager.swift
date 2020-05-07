//
//  ApiManager.swift
//  NASAImagesService
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

import Alamofire
import NASAImagesCore
import NASAImagesNetwork
import RxSwift

public final class ApiManager: ApiManageable {

    public init() {}

    public func request<T: Decodable>(
        _ request: NASAImagesNetwork.Request,
        decoderSetup: @escaping (JSONDecoder) -> Void = { _ in }
    ) -> Single<T> {
        return Single<T>.create(subscribe: { single -> Disposable in

            NFXManager.shared.request(request).validate().responseData(queue: .global(qos: .background)) { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        decoderSetup(decoder)
                        let decoded = try decoder.decode(T.self, from: data)
                        DispatchQueue.main.async {
                            single(.success(decoded))
                        }
                    } catch {
                        DispatchQueue.main.async {
                            single(.error(ApiResultError.parsingError))
                        }
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        if error._code == NSURLErrorTimedOut {
                            single(.error(ApiResultError.timeOut))
                        } else {
                            let statusCode = StatusCodeValidation(response.response?.statusCode)
                            single(.error(ApiResultError.wrongStatusCode(statusCode)))
                        }
                    }
                }
            }

            return Disposables.create {}
        })
    }

}

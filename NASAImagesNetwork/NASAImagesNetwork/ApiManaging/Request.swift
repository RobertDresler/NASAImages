//
//  Request.swift
//  NASAImagesNetwork
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

import Alamofire
import NASAImagesCore

public struct Request: URLRequestConvertible {

    typealias Header = (key: String, value: String)

    var mockPath: String {
        return !path.isEmpty ? path : baseUrl
    }

    private let baseUrl: String

    private var path = ""
    private var method: HTTPMethod = .get
    private var parameters = [String: Any]()
    private var headers = [Header]()
    private var timeout = Timeout.long
    private var httpBody: Data?
    private var encoding: ParameterEncoding = URLEncoding.default

    init(_ baseUrl: String) {
        self.baseUrl = baseUrl
    }

    func path(_ value: String) -> Request {
        var newRequest = self
        newRequest.path = value
        return newRequest
    }

    func timeout(_ value: Timeout) -> Request {
        var newRequest = self
        newRequest.timeout = value
        return newRequest
    }

    func method(_ value: HTTPMethod) -> Request {
        var newRequest = self
        newRequest.method = value
        return newRequest
    }

    /// Sets parameters for request. If any value from dictionary is `nil`, it's not used as parameter.
    func parameters(_ value: [String: Any?]) -> Request {
        var newRequest = self
        newRequest.parameters = value.compactMapValues { $0 }
        return newRequest
    }

    func header(key: String, value: String) -> Request {
        var newRequest = self
        newRequest.headers.append((key: key, value: value))
        return newRequest
    }

    func httpBody(_ value: Data) -> Request {
        var newRequest = self
        newRequest.httpBody = value
        return newRequest
    }

    func encoding(_ value: ParameterEncoding) -> Request {
        var newRequest = self
        newRequest.encoding = value
        return newRequest
    }

    public func asURLRequest() throws -> URLRequest {
        let url = try baseUrl.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.timeoutInterval = timeout
        request.httpBody = httpBody
        headers.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        var encodedRequest = try encoding.encode(request, with: httpBody == nil ? parameters : nil)
        // NOTE: This has to be here since NASA' API doesn' accept / before ?
        encodedRequest.url = URL(
            string: encodedRequest.url?.absoluteString.replacingOccurrences(of: "/?", with: "?") ?? ""
        )
        return encodedRequest
    }

}

//
//  NFXManager.swift
//  NASAImagesService
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

import Alamofire

#if NETFOX
import netfox
#endif

public final class NFXManager: Session {
    public static let shared: NFXManager = {
        let configuration = URLSessionConfiguration.default
        #if NETFOX
        configuration.protocolClasses?.insert(NFXProtocol.self, at: 0)
        #endif
        configuration.headers = .default
        let manager = NFXManager(configuration: configuration)
        return manager
    }()
}

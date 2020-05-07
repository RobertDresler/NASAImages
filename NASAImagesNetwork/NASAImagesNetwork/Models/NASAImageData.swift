//
//  NASAImageData.swift
//  NASAImages
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

import Foundation

struct NASAImageData: Decodable {

    let title: String
    let description: String?
    let center: String
    let dateCreated: Date
    let photographer: String?
    let secondaryCreator: String?
    let nasaId: String

    enum CodingKeys: String, CodingKey {
        case title, description, center, dateCreated, photographer, secondaryCreator, nasaId
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        title = try container.decode(String.self, forKey: .title)
        description = try? container.decode(String.self, forKey: .description)
        center = try container.decode(String.self, forKey: .center)
        dateCreated = try container.decode(Date.self, forKey: .dateCreated)
        photographer = try? container.decode(String.self, forKey: .photographer)
        secondaryCreator = try? container.decode(String.self, forKey: .secondaryCreator)
        nasaId = try container.decode(String.self, forKey: .nasaId)
    }

}

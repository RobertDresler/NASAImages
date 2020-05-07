//
//  SearchRequester.swift
//  NASAImagesNetwork
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

import Alamofire
import NASAImagesCore
import RxSwift

public final class SearchRequester: Requester, SearchRequestable {

    public func getImages(for searchQuery: String) -> Single<[NASAImage]> {
        let request = Request(apiUrlsProvider.urls.search)
            .parameters(["q": searchQuery, "media_type": "image"])

        let wrapperSingle: Single<CollectionWrapper<ItemsWrapper<DataWrapper<[NASAImageData]>>>> = apiManager.request(
            request,
            decoderSetup: { decoder in
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .formatted(.yyyyMMddTHHmmssZ)
            }
        )
        return wrapperSingle.map { collectionWrapper in
            let imageData = collectionWrapper.collection.items.compactMap { $0.data.first }
            return imageData.map { imageData in
                let imageBase = "https://images-assets.nasa.gov/image/\(imageData.nasaId)/\(imageData.nasaId)"
                return NASAImage(
                    title: imageData.title,
                    description: imageData.description,
                    center: imageData.center,
                    dateCreated: imageData.dateCreated,
                    photographer: imageData.photographer,
                    secondaryCreator: imageData.secondaryCreator,
                    thumbnailImageUrl: URL(string: "\(imageBase)~thumb.jpg"),
                    originalImageUrl: URL(string: "\(imageBase)~orig.jpg")
                )
            }
        }
    }

}

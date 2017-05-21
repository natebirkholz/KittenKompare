//
//  Cat.swift
//  Apply MJD
//
//  Created on 12/12/16.
//  Copyright © 2016 MJD Interactive. All rights reserved.
//

import Foundation


public typealias ModelData = [String: Any]

public protocol Model {
    init?(data: ModelData)
}


public class Cat: Model {

    public let caption: String?
    internal let imageURL: String?
    public let name: String?
    internal let source: String?
    public var image: UIImage?

    public required init?(data: ModelData) {
        guard !data.isEmpty else {
            return nil
        }

        caption = data["caption"] as? String ?? nil
        imageURL = data["image"] as? String ?? nil
        name = data["name"] as? String ?? nil
        source = data["source"] as? String ?? nil

        if let urlString = imageURL, let urlForImage = URL(string: urlString) {
            APIClient.loadImage(url: urlForImage, completion: { (maybeImage, maybeError) in
                guard maybeError == nil else {
                    // handle error
                    print(maybeError?.description as Any)
                    return
                }

                if let imageForCat = maybeImage {
                    self.image = imageForCat
                } else {
                    self.image = nil
                }

            })
        } else {
            image = nil
        }

    }
}

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


public struct Cat: Model {

    public let caption: String?
    public let imageURL: String?
    public let name: String?
    public let source: String?
    public var image: UIImage?

    public init?(data: ModelData) {
        guard !data.isEmpty else {
            return nil
        }

        caption = data["caption"] as? String ?? nil
        imageURL = data["image"] as? String ?? nil
        name = data["name"] as? String ?? nil
        source = data["source"] as? String ?? nil
        image = nil
    }
}

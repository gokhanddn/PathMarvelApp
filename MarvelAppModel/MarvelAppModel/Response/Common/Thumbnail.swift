//
//  Thumbnail.swift
//  MarvelAppModel
//
//  Created by GOKHAN on 20.04.2022.
//

import Foundation

public struct Thumbnail: Codable {
    let path: String?
    let thumbnailExtension: String?
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

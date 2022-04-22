//
//  ComicModel.swift
//  MarvelAppModel
//
//  Created by GOKHAN on 21.04.2022.
//

import Foundation

public struct ComicModel: Codable {
    public let id: Int?
    public let title: String?
    public let thumbnail: Thumbnail?
    
    public var imageUrl: String {
        guard let thumbnail = thumbnail else { return "" }
        guard let path = thumbnail.path else { return "" }
        guard let thumbnailExtension = thumbnail.thumbnailExtension else { return "" }
        return "\(path).\(thumbnailExtension)"
    }
}

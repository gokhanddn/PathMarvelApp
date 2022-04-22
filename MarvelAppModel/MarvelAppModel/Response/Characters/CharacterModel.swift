//
//  CharacterModel.swift
//  MarvelAppModel
//
//  Created by GOKHAN on 20.04.2022.
//

import Foundation

public struct CharacterModel: Codable {
    public let id: Int?
    public let name: String?
    public let thumbnail: Thumbnail?
    
    public var imageUrl: String {
        guard let thumbnail = thumbnail else { return "" }
        guard let path = thumbnail.path else { return "" }
        guard let thumbnailExtension = thumbnail.thumbnailExtension else { return "" }
        return "\(path).\(thumbnailExtension)"
    }
}

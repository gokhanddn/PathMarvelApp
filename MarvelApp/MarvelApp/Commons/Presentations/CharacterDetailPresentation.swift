//
//  CharacterDetailPresentation.swift
//  MarvelApp
//
//  Created by GOKHAN on 21.04.2022.
//

import Foundation

final class CharacterDetailPresentation: NSObject {
    
    let name: String
    let imageUrl: String
    let detail: String
    
    init(name: String, imageUrl: String, detail: String) {
        self.name = name
        self.imageUrl = imageUrl
        self.detail = detail
        super.init()
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? CharacterDetailPresentation else { return false }
        return self.name == other.name && self.imageUrl == other.imageUrl && self.detail == other.detail
    }
}

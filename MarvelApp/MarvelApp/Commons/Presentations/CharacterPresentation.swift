//
//  CharacterPresentation.swift
//  MarvelApp
//
//  Created by GOKHAN on 21.04.2022.
//

import Foundation

final class CharacterPresentation: NSObject {
    
    let name: String
    let imageUrl: String
    
    init(name: String, imageUrl: String) {
        self.name = name
        self.imageUrl = imageUrl
        super.init()
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? CharacterPresentation else { return false }
        return self.name == other.name && self.imageUrl == other.imageUrl
    }
}

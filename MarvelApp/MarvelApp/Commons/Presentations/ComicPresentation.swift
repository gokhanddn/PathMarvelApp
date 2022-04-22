//
//  ComicPresentation.swift
//  MarvelApp
//
//  Created by GOKHAN on 21.04.2022.
//

import Foundation

final class ComicPresentation: NSObject {
    
    let title: String
    let imageUrl: String
    
    init(title: String, imageUrl: String) {
        self.title = title
        self.imageUrl = imageUrl
        super.init()
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? ComicPresentation else { return false }
        return self.title == other.title && self.imageUrl == other.imageUrl
    }
}

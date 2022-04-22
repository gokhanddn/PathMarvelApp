//
//  ComicPresentation+Model.swift
//  MarvelApp
//
//  Created by GOKHAN on 21.04.2022.
//

import Foundation
import Core
import struct MarvelAppModel.ComicModel

extension ComicPresentation {
    
    convenience init(comic: ComicModel) {
        self.init(title: comic.title ?? emptyString, imageUrl: comic.imageUrl)
    }
}

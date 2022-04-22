//
//  CharacterDetailPresentation+Model.swift
//  MarvelApp
//
//  Created by GOKHAN on 21.04.2022.
//

import Foundation
import Core
import struct MarvelAppModel.CharacterDetailModel

extension CharacterDetailPresentation {
    
    convenience init(characterDetail: CharacterDetailModel) {
        self.init(name: characterDetail.name ?? emptyString,
                  imageUrl: characterDetail.imageUrl,
                  detail: characterDetail.resultDescription ?? emptyString)
    }
}

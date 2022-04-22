//
//  CharacterPresentation+Model.swift
//  MarvelApp
//
//  Created by GOKHAN on 21.04.2022.
//

import Foundation
import Core
import struct MarvelAppModel.CharacterModel

extension CharacterPresentation {
    
    convenience init(character: CharacterModel) {
        self.init(name: character.name ?? emptyString, imageUrl: character.imageUrl)
    }
}

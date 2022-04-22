//
//  ServiceProtocol.swift
//  MarvelAppService
//
//  Created by GOKHAN on 20.04.2022.
//

import Foundation
import Core
import MarvelAppModel

public protocol ServiceProtocol {
    func downloadImage(from urlString: String, completion: @escaping CallbackResponse<Data>)
    func getCharacterList(parameters: Parameters, completion: @escaping CallbackResponse<CharacterResponseModel>)
    func getCharacterDetail(characterId: Int, completion: @escaping CallbackResponse<CharacterDetailResponseModel>)
    func getComicList(characterId: Int, parameters: Parameters, completion: @escaping CallbackResponse<ComicResponseModel>)
}

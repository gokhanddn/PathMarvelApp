//
//  CharacterDetailResponseModel.swift
//  MarvelAppModel
//
//  Created by GOKHAN on 21.04.2022.
//

import Foundation

public struct CharacterDetailResponseModel: Codable {
    public let code: Int?
    public let status: String?
    public let data: CharacterDetailDataModel?
}

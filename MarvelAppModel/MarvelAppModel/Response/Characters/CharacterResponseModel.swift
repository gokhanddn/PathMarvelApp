//
//  CharacterResponseModel.swift
//  MarvelAppModel
//
//  Created by GOKHAN on 20.04.2022.
//

import Foundation

public struct CharacterResponseModel: Codable {
    public let code: Int?
    public let status: String?
    public let data: CharacterDataModel?
}

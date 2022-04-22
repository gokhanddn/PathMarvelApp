//
//  ComicResponseModel.swift
//  MarvelAppModel
//
//  Created by GOKHAN on 21.04.2022.
//

import Foundation

public struct ComicResponseModel: Codable {
    public let code: Int?
    public let status: String?
    public let data: ComicDataModel?
}

//
//  NetworkError.swift
//  Networking
//
//  Created by GOKHAN on 20.04.2022.
//

import Foundation

public enum NetworkError: Error {
    case requestFailed
    case invalidData
    case responseUnsuccessful
    case jsonConversionFailure
    case invalidURL
}

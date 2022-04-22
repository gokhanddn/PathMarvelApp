//
//  Result.swift
//  Core
//
//  Created by GOKHAN on 20.04.2022.
//

import Foundation

public enum Result<T> {
    case success(T)
    case failure(Error)
}

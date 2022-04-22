//
//  General+Typealiases.swift
//  Core
//
//  Created by GOKHAN on 20.04.2022.
//

import Foundation

// MARK: - Dictionaries
public typealias Parameters = [String: Any]
public typealias HeaderParameters = [String : String]

// MARK: - Closures
public typealias CallbackResponse<T> = (_ resp: T?) -> Void

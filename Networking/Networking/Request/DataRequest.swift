//
//  DataRequest.swift
//  Networking
//
//  Created by GOKHAN on 20.04.2022.
//

import Foundation
import Core

public protocol DataRequestProtocol {
    var urlString: String { get }
    var method: HTTPMethod { get }
    var headers: HeaderParameters { get }
    var queryItems: Parameters? { get }
    var httpBody: Data? { get }
}

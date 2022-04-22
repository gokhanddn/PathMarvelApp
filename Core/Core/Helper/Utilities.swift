//
//  Utilities.swift
//  Core
//
//  Created by GOKHAN on 20.04.2022.
//

import Foundation
import CryptoKit

public class Utilities {
    
    public static func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}

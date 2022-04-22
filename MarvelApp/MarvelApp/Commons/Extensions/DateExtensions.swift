//
//  DateExtensions.swift
//  MarvelApp
//
//  Created by GOKHAN on 22.04.2022.
//

import Foundation

extension Date {
    static func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: Date())
    }
}

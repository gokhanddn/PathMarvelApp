//
//  AppContainer.swift
//  MarvelApp
//
//  Created by GOKHAN on 20.04.2022.
//

import Foundation
import MarvelAppService

let app = AppContainer()

final class AppContainer {
    
    let router = AppRouter()
    let service = Service()
}

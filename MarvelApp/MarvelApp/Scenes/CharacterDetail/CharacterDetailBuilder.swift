//
//  CharacterDetailBuilder.swift
//  MarvelApp
//
//  Created by GOKHAN on 21.04.2022.
//

import UIKit

final class CharacterDetailBuilder {
    
    private static let storyboardName: String = "CharacterDetail"
    private static let controllerName: String = "CharacterDetailViewController"
    
    static func make(with characterId: Int) -> CharacterDetailViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: controllerName) as! CharacterDetailViewController
        viewController.viewModel = CharacterDetailViewModel(characterId: characterId, service: app.service)
        return viewController
    }
}

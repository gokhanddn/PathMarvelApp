//
//  CharacterListBuilder.swift
//  MarvelApp
//
//  Created by GOKHAN on 20.04.2022.
//

import UIKit

final class CharacterListBuilder {
    
    private static let storyboardName: String = "CharacterList"
    private static let controllerName: String = "CharacterListViewController"
    
    static func make() -> CharacterListViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: controllerName) as! CharacterListViewController
        viewController.viewModel = CharacterListViewModel(service: app.service)
        return viewController
    }
}

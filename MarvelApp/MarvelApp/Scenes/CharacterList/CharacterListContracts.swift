//
//  CharacterListContracts.swift
//  MarvelApp
//
//  Created by GOKHAN on 20.04.2022.
//

import Foundation

protocol CharacterListViewModelProtocol {
    var delegate: CharacterListViewModelDelegate? { get set }
    func load(with offset: Int)
    func selectCharacter(at index: Int)
}

enum CharacterListViewModelOutput: Equatable {
    case updateTitle(String)
    case setLoading(Bool)
    case showCharacterList([CharacterPresentation])
}

enum CharacterListViewRoute {
    case detail(Int)
}

protocol CharacterListViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: CharacterListViewModelOutput)
    func navigate(to route: CharacterListViewRoute)
}

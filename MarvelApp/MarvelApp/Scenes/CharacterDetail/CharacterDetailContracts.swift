//
//  CharacterDetailContracts.swift
//  MarvelApp
//
//  Created by GOKHAN on 21.04.2022.
//

import Foundation

protocol CharacterDetailViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: CharacterDetailViewModelOutput)
}

enum CharacterDetailViewModelOutput: Equatable {
    case updateTitle(String)
    case setLoading(Bool)
    case showCharacterDetail(CharacterDetailPresentation)
    case showComicList([ComicPresentation])
}

protocol CharacterDetailViewModelProtocol {
    var delegate: CharacterDetailViewModelDelegate? { get set }
    func load()
    func loadComics()
}

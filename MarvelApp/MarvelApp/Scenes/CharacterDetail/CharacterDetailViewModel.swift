//
//  CharacterDetailViewModel.swift
//  MarvelApp
//
//  Created by GOKHAN on 21.04.2022.
//

import Foundation
import Core
import MarvelAppService
import struct MarvelAppModel.CharacterDetailModel

final class CharacterDetailViewModel: CharacterDetailViewModelProtocol {
    
    weak var delegate: CharacterDetailViewModelDelegate?
    private let characterId: Int
    private let service: ServiceProtocol
    
    init(characterId: Int, service: ServiceProtocol) {
        self.characterId = characterId
        self.service = service
    }
    
    func load() {
        notify(.updateTitle("Character Detail"))
        notify(.setLoading(true))
        
        service.getCharacterDetail(characterId: characterId) { [weak self] resp in
            guard let self = self else { return }
            DispatchQueue.main.async {
                
                self.notify(.setLoading(false))
                
                if let resp = resp,
                   let data = resp.data,
                   let results = data.results,
                   results.count > 0 {
                    self.notify(.showCharacterDetail(CharacterDetailPresentation(characterDetail: results[0])))
                }
            }
        }
    }
    
    func loadComics() {
        var params: Parameters = [:]
        params["limit"] = 10
        params["dateRange"] = "2005-01-01,\(Date.getCurrentDate())"
        params["orderBy"] = "onsaleDate"
        service.getComicList(characterId: characterId, parameters: params) { [weak self] resp in
            guard let self = self else { return }
            DispatchQueue.main.async {
                
                if let resp = resp,
                   let data = resp.data,
                   let results = data.results {
                    let comicsPresentationList = results.map { ComicPresentation.init(comic: $0) }
                    self.notify(.showComicList(comicsPresentationList))
                }
            }
        }
    }
    
    private func notify(_ output: CharacterDetailViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}

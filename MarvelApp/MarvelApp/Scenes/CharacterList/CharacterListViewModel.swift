//
//  CharacterListViewModel.swift
//  MarvelApp
//
//  Created by GOKHAN on 20.04.2022.
//

import Foundation
import Core
import MarvelAppService
import struct MarvelAppModel.CharacterModel

final class CharacterListViewModel: CharacterListViewModelProtocol {
    
    weak var delegate: CharacterListViewModelDelegate?
    private let service: ServiceProtocol
    private var characters: [CharacterModel] = []
    
    init(service: ServiceProtocol) {
        self.service = service
    }
    
    func load(with offset: Int) {
        notify(.updateTitle("Marvel Character List"))
        notify(.setLoading(true))
        
        var params: Parameters = [:]
        params["limit"] = 30
        params["offset"] = offset
        
        service.getCharacterList(parameters: params) { [weak self] resp in
            guard let self = self else { return }
            DispatchQueue.main.async {
                
                self.notify(.setLoading(false))
                
                if let resp = resp,
                   let data = resp.data,
                   let results = data.results {
                    self.characters.append(contentsOf: results)
                }
                
                let presenatations = self.characters.map({ CharacterPresentation(character: $0) })
                self.notify(.showCharacterList(presenatations))
            }
        }
    }
    
    func selectCharacter(at index: Int) {
        let character = characters[index]
        delegate?.navigate(to: .detail(character.id ?? 0))
    }
    
    private func notify(_ output: CharacterListViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}

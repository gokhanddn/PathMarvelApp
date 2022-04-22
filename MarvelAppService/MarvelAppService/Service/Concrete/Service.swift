//
//  Service.swift
//  MarvelAppService
//
//  Created by GOKHAN on 20.04.2022.
//

import Foundation
import Core
import Networking
import MarvelAppModel

public class Service: ServiceProtocol {
    
    let networking: NetworkServiceProtocol
    
    public init() {
        networking = NetworkService()
    }
    
    public func downloadImage(from urlString: String, completion: @escaping CallbackResponse<Data>) {
        
        networking.download(with: urlString) { (result: Result<Data>) in
            
            switch result {
            case .failure(_):
                completion(nil)
                return
            case .success(let data):
                completion(data)
                return
            }
        }
    }
    
    public func getCharacterList(parameters: Parameters, completion: @escaping CallbackResponse<CharacterResponseModel>) {
        var dataRequest = DataRequest(urlString: ApiHost.production.rawValue, path: .publicPath, version: .v1)
        dataRequest.method = .get
        dataRequest.queryItems = parameters
        networking.request(with: dataRequest.getUrlRequest(with: "characters")) { (result: Result<CharacterResponseModel>) in
            switch result {
            case .success(let response):
                completion(response)
            case .failure(_):
                completion(nil)
            }
        }
    }
    
    public func getCharacterDetail(characterId: Int, completion: @escaping CallbackResponse<CharacterDetailResponseModel>) {
        var dataRequest = DataRequest(urlString: ApiHost.production.rawValue, path: .publicPath, version: .v1)
        dataRequest.method = .get
        networking.request(with: dataRequest.getUrlRequest(with: "characters/\(characterId)")) { (result: Result<CharacterDetailResponseModel>) in
            switch result {
            case .success(let response):
                completion(response)
            case .failure(_):
                completion(nil)
            }
        }
    }
    
    public func getComicList(characterId: Int, parameters: Parameters, completion: @escaping CallbackResponse<ComicResponseModel>) {
        var dataRequest = DataRequest(urlString: ApiHost.production.rawValue, path: .publicPath, version: .v1)
        dataRequest.method = .get
        dataRequest.queryItems = parameters
        networking.request(with: dataRequest.getUrlRequest(with: "characters/\(characterId)/comics")) { (result: Result<ComicResponseModel>) in
            switch result {
            case .success(let response):
                completion(response)
            case .failure(_):
                completion(nil)
            }
        }
    }
}

//
//  NetworkService.swift
//  Networking
//
//  Created by GOKHAN on 20.04.2022.
//

import Foundation
import Core

public protocol NetworkServiceProtocol {
    func request<T: Decodable>(with request: URLRequest, completion: @escaping (Result<T>) -> Void)
    func download<T: Decodable>(with urlString: String, completion: @escaping (Result<T>) -> Void)
}

public class NetworkService: NetworkServiceProtocol {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    public convenience init() {
        self.init(configuration: .default)
    }
    
    public func request<T>(with request: URLRequest, completion: @escaping (Result<T>) -> Void) where T : Decodable {
        session.dataTask(with: request) { [weak self] (data, response, err) in
            guard let self = self else { return }
            do {
                let data = try self.handleResponse(data: data, response: response, error: err)
                let response = try JSONDecoder().decode(T.self, from: data)
                completion(.success(response))
                return
            }
            catch {
                completion(.failure(error))
                return
            }
        }.resume()
    }
    
    public func download<T>(with urlString: String, completion: @escaping (Result<T>) -> Void) where T : Decodable {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let request = URLRequest(url: url, timeoutInterval: Double.infinity)
        
        session.dataTask(with: request) { [weak self] (data, response, err) in
            guard let self = self else { return }
            do {
                let data = try self.handleResponse(data: data, response: response, error: err)
                guard let data = data as? T else {
                    completion(.failure(NetworkError.invalidData))
                    return
                }
                completion(.success(data))
                return
            }
            catch {
                completion(.failure(error))
                return
            }
        }.resume()
    }
    
    private func handleResponse(data: Data?, response: URLResponse?, error: Error?) throws -> Data {
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.requestFailed
        }
        
        guard 200..<300 ~= response.statusCode else {
            throw NetworkError.responseUnsuccessful
        }
        
        guard let data = data else {
            throw NetworkError.invalidData
        }
        
        return data
    }
}

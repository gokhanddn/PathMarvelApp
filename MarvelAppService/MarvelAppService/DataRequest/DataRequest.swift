//
//  DataRequest.swift
//  MarvelAppService
//
//  Created by GOKHAN on 20.04.2022.
//

import Foundation
import Core
import Networking

struct DataRequest: DataRequestProtocol {
    
    var urlString: String
    var method: HTTPMethod = .get
    var path: Path
    var headers: HeaderParameters = [:]
    var queryItems: Parameters?
    var httpBody: Data?
    var version: ApiVersion?
    
    init(urlString: String, path: Path, version: ApiVersion? = nil) {
        self.urlString = urlString
        self.path = path
        self.version = version
    }
    
    func getUrlRequest(with endpoint: String) -> URLRequest {
        var request = URLRequest(url: getUrl(with: endpoint))
        request.httpMethod = method.rawValue
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 60
        request.allHTTPHeaderFields = headers
        request.httpBody = httpBody
        return request
    }
    
    private func getUrl(with endpoint: String) -> URL {
        var components = URLComponents(string: getUrlString(with: endpoint))
        components?.queryItems = getQueryItems()
        return components?.url ?? URL(string: urlString)!
    }
    
    private func getUrlString(with endpoint: String) -> String {
        var path = "\(path.rawValue)/\(endpoint)"
        if let version = version {
            path = "\(version.rawValue)/\(path)"
        }
        path = "\(urlString)/\(path)"
        return path
    }
    
    private func getQueryItems() -> [URLQueryItem]? {
        var pQueryItems: Parameters = [:]
        
        if let queryItems = queryItems {
            pQueryItems = queryItems
        }
        
        pQueryItems[kTimestampKey] = kTimestampValue
        pQueryItems[kApiKey] = kPublicValue
        pQueryItems[kHash] = Utilities.MD5(string: "\(kTimestampValue)\(kPrivateValue)\(kPublicValue)")
        
        if method == .get {
            var urlQueryItemList: [URLQueryItem] = []
            for queryItem in pQueryItems {
                urlQueryItemList.append(URLQueryItem(name: queryItem.key, value: unwrap(value: queryItem.value)))
            }
            return urlQueryItemList.count > 0 ? urlQueryItemList : nil
        }
        return nil
    }
    
    private func unwrap(value: Any) -> String {
        let mirror = Mirror(reflecting: value)
        if mirror.displayStyle != .optional {
            return String(describing: value)
        }
        
        if let some = mirror.children.first?.value {
            return String(describing: some)
        }
        return emptyString
    }
}

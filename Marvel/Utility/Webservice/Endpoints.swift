//
//  Endpoints.swift
//  Marvel
//
//  Created by Siddharth Chauhan on 18/11/23.
//

import Foundation

enum HttpMethods: String {
    case get = "GET"
    case post = "POST"
}

protocol EndPointType {
    var path: String { get }
    var baseUrl: String { get }
    var url: URL? { get }
    var method: HttpMethods { get }
    var parameters: Encodable? { get }
    var header: [String: String]? { get }
}

// For mock json files
protocol JsonFileName {
    var jsonFileName: String { get }
}

// List of all the webservice call cases
enum Modules {
    case characterList(CharacterListRequest)
    case comicsList(ComicsRequestModel)
}

// Json file names for mock response
extension Modules: JsonFileName {
    var jsonFileName: String {
        switch self {
        case .characterList:
            return "CharacterList"
        case .comicsList:
            return "ComicsList"
        }
    }
}

extension Modules: EndPointType {
    
    var path: String {
        switch self {
        case .characterList:
            return "characters"
        case .comicsList(let comicsRequest):
            return "characters/\(comicsRequest.characterId ?? 0)/comics"
        }
    }
    
    var baseUrl: String {
        return "https://gateway.marvel.com:443/v1/public/"
    }
    
    var url: URL? {
        let timeStamp = Date().timeIntervalSince1970.description
        var urlString = "\(baseUrl)\(path)?ts=\(timeStamp)&apikey=\(Constants.Keys.publicApiKey)&hash=\((timeStamp+Constants.Keys.privateApiKey+Constants.Keys.publicApiKey).md5Hash())"
        
        if method == .get {
            let query: String = createQueryString()
            urlString.append(query)
        }
        
        return URL(string: urlString)
    }
    
    var method: HttpMethods {
        switch self {
        case .characterList:
            return .get
        case .comicsList:
            return .get
        }
    }
    
    var parameters: Encodable? {
        
        switch self {
        case .characterList(let characterListRequest):
            return characterListRequest
        case .comicsList(let comicsRequest):
            return comicsRequest
        }
    }
    
    var header: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    // Creates query string for GET requests.
    func createQueryString() -> String {
        var query: String = ""
        if let dict = parameters?.convertToDict() {
            for (key, value) in dict {
                query += "&\(key)=\(value)"
            }
        }
        return query
    }
}

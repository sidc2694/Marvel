//
//  CharacterListModel.swift
//  Marvel
//
//  Created by Siddharth Chauhan on 18/11/23.
//

import Foundation

struct CharacterModel: Codable {
    let id: Int?
    let name: String?
    let description: String?
    let thumbnail: Thumbnail?
    let resourceURI: String?
    let comics: Comics?
    let series: Series?
    let stories: Stories?
    let events: Events?
    let urls: [Url]?
}

struct Thumbnail: Codable {
    let path: String?
    let imageExtension: String?
    var thumbnailUrl: URL?
    
    enum CodingKeys: String, CodingKey {
        case path
        case imageExtension = "extension"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.path = try container.decodeIfPresent(String.self, forKey: .path)
        self.imageExtension = try container.decodeIfPresent(String.self, forKey: .imageExtension)
        if let path = path, let imageExtension = imageExtension, let url = URL(string: path + "." + imageExtension) {
            self.thumbnailUrl = url
        }
    }
}

struct Comics: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [Item]?
    let returned: Int?
}

struct Item: Codable {
    let resourceURI: String?
    let name: String?
    let type: String?
}

struct Series: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [Item]?
    let returned: Int?
}

struct Stories: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [Item]?
    let returned: Int?
}

struct Events: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [Item]?
    let returned: Int?
}

struct Url: Codable {
    let type: String?
    let url: String?
}

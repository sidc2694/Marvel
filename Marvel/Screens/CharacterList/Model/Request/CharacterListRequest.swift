//
//  CharacterListRequestModel.swift
//  Marvel
//
//  Created by Siddharth Chauhan on 23/11/23.
//

import Foundation

struct CharacterListRequest: Encodable {
    var name: String?
    var nameStartsWith: String?
    var modifiedSince: Date?
    var comics: Int?
    var series: Int?
    var events: Int?
    var stories: Int?
    var orderBy: String?
    var limit: Int = 20
    var offset: Int?
}

//
//  CommonModel.swift
//  Marvel
//
//  Created by Siddharth Chauhan on 19/11/23.
//

import Foundation

struct CommonModel<T: Codable>: Codable {
    let code: Int!
    let status: String!
    let data: DataModel<T>!
}

struct DataModel<T: Codable>: Codable {
    let total: Int!
    let results: T!
}

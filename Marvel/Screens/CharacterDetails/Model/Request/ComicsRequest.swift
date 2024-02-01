//
//  ComicsRequestModel.swift
//  Marvel
//
//  Created by Siddharth Chauhan on 22/11/23.
//

import Foundation

struct ComicsRequestModel: Encodable {
    let characterId: Int!
    let limit: Int?
}

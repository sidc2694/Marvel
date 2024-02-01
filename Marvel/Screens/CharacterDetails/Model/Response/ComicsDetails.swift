//
//  ComicsResponseModel.swift
//  Marvel
//
//  Created by Siddharth Chauhan on 22/11/23.
//

import Foundation

struct ComicsDetails: Codable {
    let id: Int!
    let title: String?
    let description: String?
    let thumbnail: Thumbnail?
}

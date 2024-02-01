//
//  APIRequestProtocol.swift
//  Marvel
//
//  Created by Siddharth Chauhan on 23/11/23.
//

import Foundation

// APIRequestProtocol makes webservice calls testable by mocking responses for testing purpose.
protocol APIRequestProtocol {
    func request<T: Codable>(type: T.Type,
                             module: Modules,
                             completion: @escaping ((Result<DataModel<T>, APIErrors>) -> Void))
}

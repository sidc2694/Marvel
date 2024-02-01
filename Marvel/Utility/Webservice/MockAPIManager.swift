//
//  MockAPIManager.swift
//  Marvel
//
//  Created by Siddharth Chauhan on 23/11/23.
//

import Foundation

// MARK: - MockAPIManager
class MockAPIManager: APIRequestProtocol {
    // MARK: - Static Variable
    static let shared = MockAPIManager()
    
    // MARK: - Private Variable
    private let networkHandler: MockNetworkHandler
    private let responseHandler: ResponseHandler
    
    // MARK: - Initializer
    private init() {
        self.networkHandler = MockNetworkHandler()
        self.responseHandler = ResponseHandler()
    }
    
    // MARK: - Request Call
    
    /// Generic method to make mock webservice call
    /// - Parameters:
    ///   - type: Type of object to be returned
    ///   - module: Enum defining which mock webservice call to make
    ///   - completion: Returns result with success or failure
    func request<T: Codable>(type: T.Type,
                             module: Modules,
                             completion: @escaping ((Result<DataModel<T>, APIErrors>) -> Void)) {
        
        self.networkHandler.getApiResponse(jsonFileName: module.jsonFileName) { result in
            switch result {
            case .success(let data):
                self.responseHandler.parseResponse(type: type, data: data) { result in
                    switch result {
                    case .success(let response):
                        completion(.success(response))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
}

// MARK: - MockNetworkHandler
class MockNetworkHandler {
    
    func getApiResponse(jsonFileName: String, completion: @escaping ((Result<Data, APIErrors>) -> Void)) {
        let data = self.readLocalJSONFile(forName: jsonFileName)
        guard let data else { return completion(.failure(.invalidData)) }
        completion(.success(data))
    }
    
    /// Read from JSON file
    /// - Parameter name: Name of JOSN file
    /// - Returns: Return file content in Data format
    func readLocalJSONFile(forName name: String) -> Data? {
        do {
            if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return data
            }
        } catch {
            print("error: \(error)")
        }
        return nil
    }
}

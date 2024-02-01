//
//  APIManager.swift
//  Marvel
//
//  Created by Siddharth Chauhan on 18/11/23.
//

import Foundation

// List of all the possible errors that can occur while making webservice request.
enum APIErrors: Error {
    case invalidUrl
    case invalidData
    case invalidBody
    case invalidResponse
    case network(Error?)
    case decode(Error?)
    case decodingFailed
    case noInternet
}

extension APIErrors: LocalizedError {
    var failureReason: String? {
        switch self {
        case .invalidUrl:
            return Constants.Errors.invalidUrl
        case .invalidData:
            return Constants.Errors.invalidData
        case .invalidBody:
            return Constants.Errors.invalidBody
        case .invalidResponse:
            return Constants.Errors.invalidResponse
        case .network(let error):
            return error?.localizedDescription
        case .decode(let error):
            return error?.localizedDescription
        case .decodingFailed:
            return Constants.Errors.decodingFailed
        case .noInternet:
            return Constants.Errors.noInternetAvailable
        }
    }
}

// MARK: - APIManager
class APIManager: APIRequestProtocol {
    // MARK: - Static Variable
    static let shared = APIManager()
    
    // MARK: - Private Variables
    private let networkHandler: NetworkHandler
    private let responseHandler: ResponseHandler
    private var isInternetAvailable: Bool = true
    
    // MARK: - Initializer
    private init() {
        self.networkHandler = NetworkHandler()
        self.responseHandler = ResponseHandler()
    }
    
    // MARK: - Request Call
    
    
    /// Generic method to make webservice call
    /// - Parameters:
    ///   - type: Type of object to be returned
    ///   - module: Enum defining which webservice call to make
    ///   - completion: Returns result with success or failure
    func request<T: Codable>(type: T.Type,
                             module: Modules,
                             completion: @escaping ((Result<DataModel<T>, APIErrors>) -> Void)) {
        guard let url = module.url else { return completion(.failure(.invalidUrl)) }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = module.method.rawValue
        urlRequest.allHTTPHeaderFields = module.header
        
        if let parameters = module.parameters, module.method == .post {
            do {
                urlRequest.httpBody = try JSONEncoder().encode(parameters)
            } catch {
                return completion(.failure(.invalidBody))
            }
        }
        
        // Checks for internet connectivity before making webservice call
        guard Reachability.shared.isInternetAvailable else { return completion(.failure(.noInternet)) }
        
        self.networkHandler.getApiResponse(request: urlRequest) { result in
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

// MARK: - NetworkHandler
class NetworkHandler {
    func getApiResponse(request: URLRequest,
                        completion: @escaping ((Result<Data, APIErrors>) -> Void)) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else { return completion(.failure(.network(error))) }
            guard let data else { return completion(.failure(.invalidData)) }
            guard let responseCode = response as? HTTPURLResponse,
                  200...299 ~= responseCode.statusCode else { return completion(.failure(.invalidResponse)) }
            completion(.success(data))
        }
        task.resume()
    }
}

// MARK: - ResponseHandler
class ResponseHandler {
    func parseResponse<T: Codable>(type: T.Type,
                                     data: Data,
                                     completion: @escaping ((Result<DataModel<T>, APIErrors>) -> Void)) {
        do {
            let response = try JSONDecoder().decode(CommonModel<T>.self, from: data)
            guard let responseData = response.data else {
                return completion(.failure(.decodingFailed))
            }
            completion(.success(responseData))
        } catch {
            completion(.failure(.decode(error)))
        }
        
    }
}

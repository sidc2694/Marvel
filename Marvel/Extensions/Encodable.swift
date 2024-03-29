//
//  Encodable.swift
//  Marvel
//
//  Created by Siddharth Chauhan on 20/11/23.
//

import Foundation

extension Encodable {
    
    // Convert Encodable object to dictionary
    func convertToDict() -> Dictionary<String, Any>? {
        var dict: Dictionary<String, Any>? = nil
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
            dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, Any>
            
        } catch {
            print(error)
        }
        return dict
    }
}

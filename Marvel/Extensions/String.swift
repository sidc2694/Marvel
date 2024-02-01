//
//  String.swift
//  Marvel
//
//  Created by Siddharth Chauhan on 19/11/23.
//

import Foundation
import CryptoKit

extension String {
    func md5Hash() -> String {
        Insecure.MD5.hash(data: Data(self.utf8)).map { String(format: "%02hhx", $0) }.joined()
    }
}

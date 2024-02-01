//
//  Reachability.swift
//  Marvel
//
//  Created by Siddharth Chauhan on 31/01/24.
//

import Network

// Reachability checks for internet connection of the application.
class Reachability {
    static let shared = Reachability()
    var isInternetAvailable = true
    let monitor = NWPathMonitor()
    
    private init() {
        checkNetworkConnectivity()
    }
    
    func checkNetworkConnectivity() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.isInternetAvailable = true
            } else {
                self.isInternetAvailable = false
            }

            print(path.isExpensive)
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
}

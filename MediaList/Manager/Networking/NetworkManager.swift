//
//  NetworkManager.swift
//  MediaList
//
//  Created by KaiD on 04/02/2023.
//

import Foundation
import Alamofire

enum NetworkStatus {
    case connected, disconnected
}

class NetworkManager {
    /*
     * Singleton instance variable
     */
    public static let shared = NetworkManager()
    
    public var networkStatus: NetworkStatus = .connected
    
    private init() {
        
    }
}

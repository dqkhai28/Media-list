//
//  APIRequest.swift
//  MediaList
//
//  Created by KaiD on 04/02/2023.
//

import Foundation
import Alamofire

class APIRequest {
    public static let shared = APIRequest()
    
    private init() {
        
    }
    
    /*
     * @Func: request - send request
     * @Param: API - API, method - get/post, parameters - parameters, completion: callback func
     * @Return: none
     */
    func request(_ api: APIData, method: HTTPMethod = .get, parameters: Parameters? = nil, completion: APIData.CompletionHandle? = nil) {
        Alamofire.AF.request(api.path, method: method, parameters: parameters).responseData { response in
            completion?(response)
        }
    }
}

//
//  APIManager.swift
//  MediaList
//
//  Created by KaiD on 04/02/2023.
//

import Foundation
import Alamofire

enum APIData {
    typealias CompletionHandle = (AFDataResponse<Data>) -> Void
    case initialize
    var path: String {
        switch self {
        case .initialize:
            return "https://itunes.apple.com/search?term=star&country=au&media=movie&;all"
        }
    }
}

extension Alamofire.DataResponse {
    /*
        * @Func: dataAs
        * @Param: T
        * @Return: T
        * Decription : auto map json to model
    */
    func dataAs<T: Decodable>() -> T? {
        guard let data = data else {
            return nil
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        // debug
        do {
            let _ = try decoder.decode(T.self, from: data)
        } catch {
            print("*************", error, data, String(describing: data))
        }
        
        let hoge = try? decoder.decode(T.self, from: data)
        return hoge
    }
}

//
//  MovieListViewModel.swift
//  MediaList
//
//  Created by KaiD on 04/02/2023.
//

import Foundation
import RealmSwift

// Adding protocol to transform struct to Realm Object
public protocol Persistable {
    associatedtype RealmMovieModel: RealmSwift.Object
    init(realmModel: RealmMovieModel)
    func getRealmModel() -> RealmMovieModel
}

struct MovieModel {
    let id: Int
    let name: String
    let imageSmall: String
    let imageLarge: String
    let price: String
    let genre: String
    let description: String
    var isFavorite: Bool = false
    
    init(apiModel: InitializeAPIResult) {
        self.id = apiModel.trackId ?? 0
        self.name = apiModel.trackName ?? ""
        self.imageSmall = apiModel.artworkUrl60 ?? ""
        self.imageLarge = apiModel.artworkUrl100 ?? ""
        self.price = "$\(apiModel.trackHdPrice ?? 0.0)"
        self.genre = apiModel.primaryGenreName ?? ""
        self.description = apiModel.longDescription ?? ""
    }
}

// Conforming to protocol
extension MovieModel: Persistable {
    public init(realmModel: RealmMovieModel) {
        self.id = realmModel.id
        self.name = realmModel.name
        self.imageSmall = realmModel.imageSmall
        self.imageLarge = realmModel.imageLarge
        self.price = realmModel.price
        self.genre = realmModel.genre
        self.description = realmModel.movieDescription
        self.isFavorite = true
    }
    
    public func getRealmModel() -> RealmMovieModel {
        let realmMovieModel = RealmMovieModel()
        realmMovieModel.id = self.id
        realmMovieModel.name = self.name
        realmMovieModel.imageSmall = self.imageSmall
        realmMovieModel.imageLarge = self.imageLarge
        realmMovieModel.price = self.price
        realmMovieModel.genre = self.genre
        realmMovieModel.movieDescription = self.description
        return realmMovieModel
    }
}

// Create model for Realm
class RealmMovieModel: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var imageSmall = ""
    @objc dynamic var imageLarge = ""
    @objc dynamic var price = ""
    @objc dynamic var genre = ""
    @objc dynamic var movieDescription = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

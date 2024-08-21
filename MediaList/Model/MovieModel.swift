//
//  MovieListViewModel.swift
//  MediaList
//
//  Created by KaiD on 04/02/2023.
//

import Foundation
/*
 Track Name
 Artwork (there are multiple size formats, you should pick one that you consider appropriate for the task)
 Price
 Genre
 */
struct MovieModel {
    let id: Int
    let name: String
    let imageSmall: String
    let imageLarge: String
    let price: String
    let genre: String
    
    init(apiModel: InitializeAPIResult) {
        self.id = apiModel.trackId ?? 0
        self.name = apiModel.trackName ?? ""
        self.imageSmall = apiModel.artworkUrl30 ?? ""
        self.imageLarge = apiModel.artworkUrl100 ?? ""
        self.price = "$\(apiModel.trackHdPrice ?? 0.0)"
        self.genre = apiModel.primaryGenreName ?? ""
    }
}

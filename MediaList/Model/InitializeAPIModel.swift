//
//  InitializeAPIResponse.swift
//  MediaList
//
//  Created by KaiD on 04/02/2023.
//

import Foundation

struct InitializeAPIResponse: Codable {
    var resultCount: Int? = nil
    var results: [InitializeAPIResult]? = []
    
    enum CodingKeys: String, CodingKey {
        case resultCount = "resultCount"
        case results     = "results"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        resultCount = try values.decodeIfPresent(Int.self, forKey: .resultCount )
        results = try values.decodeIfPresent([InitializeAPIResult].self , forKey: .results)
    }
    
    init() {
        
    }
}

struct InitializeAPIResult: Codable {
    var wrapperType: String? = nil
    var kind: String? = nil
    var collectionId: Int? = nil
    var trackId: Int? = nil
    var artistName: String? = nil
    var collectionName: String? = nil
    var trackName: String? = nil
    var collectionCensoredName: String? = nil
    var trackCensoredName: String? = nil
    var collectionArtistId: Int? = nil
    var collectionArtistViewUrl: String? = nil
    var collectionViewUrl: String? = nil
    var trackViewUrl: String? = nil
    var previewUrl: String? = nil
    var artworkUrl30: String? = nil
    var artworkUrl60: String? = nil
    var artworkUrl100: String? = nil
    var collectionPrice: Double? = nil
    var trackPrice: Double? = nil
    var collectionHdPrice: Double? = nil
    var trackHdPrice: Double? = nil
    var releaseDate: String? = nil
    var collectionExplicitness: String? = nil
    var trackExplicitness: String? = nil
    var discCount: Int? = nil
    var discNumber: Int? = nil
    var trackCount: Int? = nil
    var trackNumber: Int? = nil
    var trackTimeMillis: Int? = nil
    var country: String? = nil
    var currency: String? = nil
    var primaryGenreName: String? = nil
    var contentAdvisoryRating: String? = nil
    var longDescription: String? = nil
    var hasITunesExtras: Bool? = nil
    
    enum CodingKeys: String, CodingKey {
        case wrapperType = "wrapperType"
        case kind = "kind"
        case collectionId = "collectionId"
        case trackId = "trackId"
        case artistName = "artistName"
        case collectionName = "collectionName"
        case trackName = "trackName"
        case collectionCensoredName = "collectionCensoredName"
        case trackCensoredName = "trackCensoredName"
        case collectionArtistId = "collectionArtistId"
        case collectionArtistViewUrl = "collectionArtistViewUrl"
        case collectionViewUrl = "collectionViewUrl"
        case trackViewUrl = "trackViewUrl"
        case previewUrl = "previewUrl"
        case artworkUrl30 = "artworkUrl30"
        case artworkUrl60 = "artworkUrl60"
        case artworkUrl100 = "artworkUrl100"
        case collectionPrice = "collectionPrice"
        case trackPrice = "trackPrice"
        case collectionHdPrice = "collectionHdPrice"
        case trackHdPrice = "trackHdPrice"
        case releaseDate = "releaseDate"
        case collectionExplicitness = "collectionExplicitness"
        case trackExplicitness = "trackExplicitness"
        case discCount = "discCount"
        case discNumber = "discNumber"
        case trackCount = "trackCount"
        case trackNumber = "trackNumber"
        case trackTimeMillis = "trackTimeMillis"
        case country = "country"
        case currency = "currency"
        case primaryGenreName = "primaryGenreName"
        case contentAdvisoryRating = "contentAdvisoryRating"
        case longDescription = "longDescription"
        case hasITunesExtras = "hasITunesExtras"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        wrapperType = try values.decodeIfPresent(String.self, forKey: .wrapperType)
        kind = try values.decodeIfPresent(String.self, forKey: .kind)
        collectionId = try values.decodeIfPresent(Int.self, forKey: .collectionId)
        trackId = try values.decodeIfPresent(Int.self, forKey: .trackId)
        artistName = try values.decodeIfPresent(String.self, forKey: .artistName)
        collectionName = try values.decodeIfPresent(String.self, forKey: .collectionName)
        trackName = try values.decodeIfPresent(String.self, forKey: .trackName)
        collectionCensoredName = try values.decodeIfPresent(String.self, forKey: .collectionCensoredName)
        trackCensoredName = try values.decodeIfPresent(String.self, forKey: .trackCensoredName)
        collectionArtistId = try values.decodeIfPresent(Int.self, forKey: .collectionArtistId)
        collectionArtistViewUrl = try values.decodeIfPresent(String.self, forKey: .collectionArtistViewUrl)
        collectionViewUrl = try values.decodeIfPresent(String.self, forKey: .collectionViewUrl)
        trackViewUrl = try values.decodeIfPresent(String.self, forKey: .trackViewUrl)
        previewUrl = try values.decodeIfPresent(String.self, forKey: .previewUrl)
        artworkUrl30 = try values.decodeIfPresent(String.self, forKey: .artworkUrl30)
        artworkUrl60 = try values.decodeIfPresent(String.self, forKey: .artworkUrl60)
        artworkUrl100 = try values.decodeIfPresent(String.self, forKey: .artworkUrl100)
        collectionPrice = try values.decodeIfPresent(Double.self, forKey: .collectionPrice)
        trackPrice = try values.decodeIfPresent(Double.self, forKey: .trackPrice)
        collectionHdPrice = try values.decodeIfPresent(Double.self, forKey: .collectionHdPrice)
        trackHdPrice = try values.decodeIfPresent(Double.self, forKey: .trackHdPrice)
        releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate)
        collectionExplicitness = try values.decodeIfPresent(String.self, forKey: .collectionExplicitness)
        trackExplicitness = try values.decodeIfPresent(String.self, forKey: .trackExplicitness)
        discCount = try values.decodeIfPresent(Int.self, forKey: .discCount)
        discNumber = try values.decodeIfPresent(Int.self, forKey: .discNumber)
        trackCount = try values.decodeIfPresent(Int.self, forKey: .trackCount)
        trackNumber = try values.decodeIfPresent(Int.self, forKey: .trackNumber)
        trackTimeMillis = try values.decodeIfPresent(Int.self, forKey: .trackTimeMillis)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        primaryGenreName = try values.decodeIfPresent(String.self, forKey: .primaryGenreName)
        contentAdvisoryRating = try values.decodeIfPresent(String.self, forKey: .contentAdvisoryRating)
        longDescription = try values.decodeIfPresent(String.self, forKey: .longDescription)
        hasITunesExtras = try values.decodeIfPresent(Bool.self, forKey: .hasITunesExtras)
    }
    
    init() {
        
    }
}

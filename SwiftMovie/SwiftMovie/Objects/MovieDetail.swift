//
//  MovieDetail.swift
//  SwiftMovie
//
//  Created by Lucas Farah on 8/27/20.
//  Copyright © 2020 Lucas Farah. All rights reserved.
//

import Foundation

struct MovieDetail: Codable {
    let title: String
    let imageURLPath: String
    let releaseDateStr: String
    let genreIds: [Int]?
    let likesCount: Int
    let viewsCount: Double

    var imageURL: URL? {
        let urlStr = "https://image.tmdb.org/t/p/w500\(imageURLPath)"
        return URL(string: urlStr)
    }
    
    var releaseYear: String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: releaseDateStr) {
            let year = Calendar.current.component(.year, from: date)
            return "\(year)"
        } else {
            return nil
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case title = "original_title"
        case imageURLPath = "poster_path"
        case releaseDateStr = "release_date"
        case genreIds = "genre_ids"
        case likesCount = "vote_count"
        case viewsCount = "popularity"
    }
}

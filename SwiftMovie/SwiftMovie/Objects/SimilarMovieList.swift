//
//  SimilarMovieList.swift
//  SwiftMovie
//
//  Created by Lucas Farah on 8/27/20.
//  Copyright © 2020 Lucas Farah. All rights reserved.
//

import Foundation

struct SimilarMovieList: Codable {
    var results: [MovieDetail]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}

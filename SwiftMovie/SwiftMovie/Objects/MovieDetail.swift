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
    
    enum CodingKeys: String, CodingKey {
        case title = "original_title"
    }
}

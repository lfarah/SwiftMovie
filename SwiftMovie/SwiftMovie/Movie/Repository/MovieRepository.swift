//
//  MovieRepository.swift
//  SwiftMovie
//
//  Created by Lucas Farah on 8/27/20.
//  Copyright © 2020 Lucas Farah. All rights reserved.
//

import Foundation
import RxSwift

struct MovieRepository {
    func requestMovieDetail() -> Observable<MovieDetail> {
        return Networker.request(endpoint: .movie(id: "373558"), responseType: MovieDetail.self)
    }
    
    func requestSimilarMovies() -> Observable<SimilarMovieList> {
        return Networker.request(endpoint: .similarMovies(id: "373558"), responseType: SimilarMovieList.self)
    }
    
    func requestGenres() -> Observable<MovieGenreList> {
        return Networker.request(endpoint: .genres, responseType: MovieGenreList.self)
    }
}

//
//  MovieDetailViewModel.swift
//  SwiftMovie
//
//  Created by Lucas Farah on 8/27/20.
//  Copyright © 2020 Lucas Farah. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct MovieDetailViewModel {
    let repository = MovieRepository()
    let bag = DisposeBag()
    
    enum Section {
        case mainMovie(title: String, imageURL: URL?, likesCount: Int, viewsCount: Double)
        case similarMovie(title: String, imageURL: URL?, year: String?, genres: [String])
    }
    
    struct MovieDetailInfo {
        let detail: MovieDetail
        let similarMovies: [MovieDetail]
        let genreList: [MovieGenre]
    }

    let dataSource = BehaviorRelay<[Section]>(value: [])
    
    let movieInfo = BehaviorRelay<MovieDetailInfo?>(value: nil)
    
    init() {
        requestMovieInfo()
            .bind(to: movieInfo)
            .disposed(by: bag)
        
        movieInfo
            .filterNotNil()
            .map { info -> [Section] in
                var sections: [Section] = []
                let mainMovieSection = Section.mainMovie(title: info.detail.title,
                                                         imageURL: info.detail.imageURL,
                                                         likesCount: info.detail.likesCount,
                                                         viewsCount: info.detail.viewsCount)
                sections += [mainMovieSection]
                
                sections += info.similarMovies.map({ (movie) -> Section in
                    let genres = movie.genreIds?.compactMap({ (genreId) -> String? in
                        info.genreList.first(where: { $0.id == genreId })?.name
                    }) ?? []
                    
                    return .similarMovie(title: movie.title, imageURL: movie.imageURL, year: movie.releaseYear, genres: genres)
                })
                
                return sections
            }
            .bind(to: dataSource)
            .disposed(by: bag)
    }
    
    func requestMovieInfo() -> Observable<MovieDetailInfo> {
        let detailRequest = repository.requestMovieDetail()
        let similarMoviesRequest = repository.requestSimilarMovies()
        let movieGenreRequest = repository.requestGenres()

        return Observable.combineLatest(detailRequest, similarMoviesRequest, movieGenreRequest)
            .map { (requests) -> MovieDetailInfo in
                return MovieDetailInfo(detail: requests.0, similarMovies: requests.1.results, genreList: requests.2.genres)
            }
    }
}

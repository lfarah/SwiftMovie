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
        case mainMovie(title: String)
    }
    
    let dataSource = BehaviorRelay<[Section]>(value: [])
    
    let movieInfo = BehaviorRelay<(detail: MovieDetail, similarMovies: [MovieDetail])?>(value: nil)

    init() {
        requestMovieInfo()
            .bind(to: movieInfo)
            .disposed(by: bag)
        
        movieInfo
            .filterNotNil()
            .map { info -> [Section] in
                var sections: [Section] = []
                let mainMovieSection = Section.mainMovie(title: info.detail.title)
                sections += [mainMovieSection]
                
                sections += info.similarMovies.map({ (movie) -> Section in
                    return .mainMovie(title: movie.title)
                })
                
                return sections
            }
            .bind(to: dataSource)
            .disposed(by: bag)
    }
    
    func requestMovieInfo() -> Observable<(detail: MovieDetail, similarMovies: [MovieDetail])> {
        let detailRequest = repository.requestMovieDetail()
        let similarMoviesRequest = repository.requestSimilarMovies()

        return Observable.combineLatest(detailRequest, similarMoviesRequest)
            .map { (requests) -> (detail: MovieDetail, similarMovies: [MovieDetail]) in
                return (detail: requests.0, similarMovies: requests.1.results)
            }
    }
}

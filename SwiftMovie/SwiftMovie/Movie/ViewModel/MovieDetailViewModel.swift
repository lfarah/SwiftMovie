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
    
    let dataSource = BehaviorRelay<(detail: MovieDetail, similarMovies: [MovieDetail])?>(value: nil)
    
    init() {
        requestMovieInfo()
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

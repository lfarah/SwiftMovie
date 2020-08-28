//
//  Networker.swift
//  SwiftMovie
//
//  Created by Lucas Farah on 8/27/20.
//  Copyright © 2020 Lucas Farah. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

enum EndpointType {
    case movie(id: String)
    case similarMovies(id: String)
    
    var url: String {
        switch self {
        case .movie(let id):
            return "movie/\(id)"
        case .similarMovies(let id):
            return "movie/\(id)/similar"

        }
    }
}

struct Networker {
    static func request<T: Codable>(endpoint: EndpointType, responseType: T.Type) -> Observable<T> {
        let root = "https://api.themoviedb.org/3/"
        let url = root + endpoint.url + "?api_key=b2ab6fb06a5f5d93c4e4b76de029371a"
        return Observable.create { (observer) -> Disposable in
            
            AF.request(url).responseDecodable(of: responseType) { (response) in
                switch response.result {
                case .success(let result):
                    observer.onNext(result)
                    observer.onCompleted()

                case .failure(let error):
                    observer.onError(error)
                    observer.onCompleted()                    
                }
            }

            return Disposables.create()
        }
    }
}

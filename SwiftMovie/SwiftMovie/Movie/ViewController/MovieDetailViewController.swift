//
//  MovieDetailViewController.swift
//  SwiftMovie
//
//  Created by Lucas Farah on 8/27/20.
//  Copyright © 2020 Lucas Farah. All rights reserved.
//

import UIKit
import RxSwift

class MovieDetailViewController: UIViewController {
    
    let viewModel = MovieDetailViewModel()
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        viewModel.dataSource
            .filterNotNil()
            .subscribe(onNext: { (info) in
                print("info: \(info)")
            })
            .disposed(by: bag)
        
        view.backgroundColor = .red
    }
}

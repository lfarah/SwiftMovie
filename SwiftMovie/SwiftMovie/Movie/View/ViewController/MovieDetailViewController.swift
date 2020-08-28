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
    
    let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        layout()
        bind()
    }
}

extension MovieDetailViewController {
    func layout() {
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func bind() {
        tableView.dataSource = self
        tableView.register(cellClass: MainMovieCell.self)
        
        viewModel.dataSource
            .subscribe(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .disposed(by: bag)
    }
}

extension MovieDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch viewModel.dataSource.value[indexPath.row] {
            
        case .mainMovie(let title):
            return configureMainMovieCell(title: title, indexPath: indexPath)
        }
    }
}

extension MovieDetailViewController {
    func configureMainMovieCell(title: String, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueResuableCell(type: MainMovieCell.self, indexPath: indexPath)
        cell.title = title
        
        return cell
    }
}

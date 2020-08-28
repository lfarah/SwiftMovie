//
//  MovieDetailViewController.swift
//  SwiftMovie
//
//  Created by Lucas Farah on 8/27/20.
//  Copyright © 2020 Lucas Farah. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MovieDetailViewController: UIViewController {
    
    let viewModel = MovieDetailViewModel()
    let bag = DisposeBag()
    
    let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.05098039216, green: 0.05098039216, blue: 0.05098039216, alpha: 1)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        layout()
        bind()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
}

// MARK: - Setup
fileprivate extension MovieDetailViewController {
    func layout() {
        view.backgroundColor = #colorLiteral(red: 0.05098039216, green: 0.05098039216, blue: 0.05098039216, alpha: 1)
        
        view.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func bind() {
        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(cellClass: MainMovieCell.self)
        tableView.register(cellClass: SimilarMovieCell.self)

        viewModel.dataSource
            .subscribe(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .disposed(by: bag)
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension MovieDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch viewModel.dataSource.value[indexPath.row] {
            
        case .mainMovie(let title, let imageURL, let likesCount, let viewsCount):
            return configureMainMovieCell(title: title, imageURL: imageURL, likesCount: likesCount, viewsCount: viewsCount, indexPath: indexPath)
        case .similarMovie(let title, let imageURL, let releaseYear, let genres):
            return configureSimilarMovieCell(title: title, imageURL: imageURL, releaseYear: releaseYear, genres: genres, indexPath: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch viewModel.dataSource.value[indexPath.row] {
            
        case .mainMovie:
            return 300
        case .similarMovie:
            return 120
        }
    }
}

// MARK: - Configure Cell
extension MovieDetailViewController {
    func configureMainMovieCell(title: String, imageURL: URL?, likesCount: Int, viewsCount: Double, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueResuableCell(type: MainMovieCell.self, indexPath: indexPath)
        cell.title = title
        cell.imageURL = imageURL
        cell.likesCount = likesCount
        cell.viewsCount = viewsCount

        let disposable = cell.likeButton.rx.tap
            .subscribe(onNext: { _ in
                cell.isLiked.toggle()
                cell.likesCount = cell.isLiked ? likesCount + 1 : likesCount
            })
        cell.registerButtonEvent(disposable: disposable)
        return cell
    }
    
    func configureSimilarMovieCell(title: String, imageURL: URL?, releaseYear: String?, genres: [String], indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueResuableCell(type: SimilarMovieCell.self, indexPath: indexPath)
        cell.title = title
        cell.imageURL = imageURL
        cell.year = releaseYear ?? ""
        cell.category = genres.joined(separator: ", ")
        return cell
    }
}

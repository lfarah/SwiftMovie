//
//  MainMovieCell.swift
//  SwiftMovie
//
//  Created by Lucas Farah on 8/27/20.
//  Copyright © 2020 Lucas Farah. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift

class MainMovieCell: UITableViewCell {

    struct Constants {
        static let Margin: CGFloat = 16
    }
    
    fileprivate let titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .yellow
        view.font = .systemFont(ofSize: 18, weight: .black)
        view.numberOfLines = 0
        return view
    }()
    
    fileprivate let backgroundInfoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.05098039216, green: 0.05098039216, blue: 0.05098039216, alpha: 1)
        return view
    }()
    
    fileprivate let posterImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    fileprivate let likesImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "suit.heart.fill")
        view.tintColor = .white
        return view
    }()
    
    fileprivate let likesLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.font = .systemFont(ofSize: 12, weight: .regular)
        return view
    }()
    
    fileprivate let viewsImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "eye.fill")
        view.tintColor = .white
        return view
    }()
    
    fileprivate let viewsLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.font = .systemFont(ofSize: 12, weight: .regular)
        return view
    }()

    let likeButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(UIImage(systemName: "suit.heart"), for: .normal)
        view.tintColor = .yellow
        return view
    }()

    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    var imageURL: URL? = nil {
        didSet {
            posterImageView.kf.setImage(with: imageURL)
        }
    }
    
    var likesCount: Int = 0 {
        didSet {
            likesLabel.text = "\(likesCount) Likes"
        }
    }
    
    var viewsCount: Double = 0 {
        didSet {
            viewsLabel.text = "\(viewsCount) Views"
        }
    }
    
    var isLiked: Bool = false {
        didSet {
            let imageName = isLiked ? "suit.heart.fill" : "suit.heart"
            likeButton.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
        
    var buttonEventDisposable: Disposable?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup
fileprivate extension MainMovieCell {
    func layout() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(backgroundInfoView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(likesImageView)
        contentView.addSubview(likesLabel)
        contentView.addSubview(viewsImageView)
        contentView.addSubview(viewsLabel)
        contentView.addSubview(likeButton)

        posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

        likesImageView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        likesImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.Margin).isActive = true

        likesLabel.topAnchor.constraint(equalTo: likesImageView.topAnchor).isActive = true
        likesLabel.bottomAnchor.constraint(equalTo: likesImageView.bottomAnchor).isActive = true
        likesLabel.leadingAnchor.constraint(equalTo: likesImageView.trailingAnchor, constant: Constants.Margin / 2).isActive = true

        viewsImageView.leadingAnchor.constraint(equalTo: likesLabel.trailingAnchor, constant: Constants.Margin).isActive = true
        viewsImageView.centerYAnchor.constraint(equalTo: likesImageView.centerYAnchor).isActive = true

        viewsLabel.topAnchor.constraint(equalTo: viewsImageView.topAnchor).isActive = true
        viewsLabel.bottomAnchor.constraint(equalTo: viewsImageView.bottomAnchor).isActive = true
        viewsLabel.leadingAnchor.constraint(equalTo: viewsImageView.trailingAnchor, constant: Constants.Margin / 2).isActive = true

        titleLabel.bottomAnchor.constraint(equalTo: likesImageView.topAnchor, constant: -Constants.Margin / 2).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Margin).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: likeButton.leadingAnchor, constant: -Constants.Margin / 2).isActive = true

        likeButton.topAnchor.constraint(equalTo: titleLabel.topAnchor).isActive = true
        likeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Margin).isActive = true

        backgroundInfoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        backgroundInfoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        backgroundInfoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        backgroundInfoView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -Constants.Margin).isActive = true
    }
}

// MARK: - External Methods
extension MainMovieCell {
    func registerButtonEvent(disposable: Disposable) {
        buttonEventDisposable?.dispose()
        buttonEventDisposable = disposable
    }
}

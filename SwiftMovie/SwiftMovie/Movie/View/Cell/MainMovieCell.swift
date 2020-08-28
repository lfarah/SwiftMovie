//
//  MainMovieCell.swift
//  SwiftMovie
//
//  Created by Lucas Farah on 8/27/20.
//  Copyright © 2020 Lucas Farah. All rights reserved.
//

import UIKit
import Kingfisher

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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainMovieCell {
    func layout() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(backgroundInfoView)
        contentView.addSubview(titleLabel)
        
        posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Margin).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Margin).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.Margin).isActive = true

        backgroundInfoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        backgroundInfoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        backgroundInfoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        backgroundInfoView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -Constants.Margin).isActive = true
    }
}

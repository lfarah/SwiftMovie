//
//  SimilarMovieCell.swift
//  SwiftMovie
//
//  Created by Lucas Farah on 8/27/20.
//  Copyright © 2020 Lucas Farah. All rights reserved.
//

import UIKit
import Kingfisher

class SimilarMovieCell: UITableViewCell {

    struct Constants {
        static let Margin: CGFloat = 16
    }
    
    fileprivate let titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .yellow
        view.font = .systemFont(ofSize: 14, weight: .regular)
        view.numberOfLines = 0
        return view
    }()
    
    fileprivate let yearLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .yellow
        view.font = .systemFont(ofSize: 12, weight: .regular)
        return view
    }()
    
    fileprivate let categoryLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.font = .systemFont(ofSize: 12, weight: .regular)
        return view
    }()

    fileprivate let posterImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    fileprivate let infoVerticalStackview: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        view.spacing = Constants.Margin / 2
        return view
    }()
    
    fileprivate let infoHorizontalStackview: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .leading
        view.distribution = .fill
        view.spacing = Constants.Margin / 2
        return view
    }()

    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    var year: String = "" {
        didSet {
            yearLabel.text = year
        }
    }
    
    var category: String = "" {
        didSet {
            categoryLabel.text = category
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

extension SimilarMovieCell {
    func layout() {
        backgroundColor = #colorLiteral(red: 0.05098039216, green: 0.05098039216, blue: 0.05098039216, alpha: 1)
        
        contentView.addSubview(posterImageView)
        contentView.addSubview(infoVerticalStackview)

        infoVerticalStackview.addArrangedSubview(titleLabel)
        infoVerticalStackview.addArrangedSubview(infoHorizontalStackview)
        infoHorizontalStackview.addArrangedSubview(yearLabel)
        infoHorizontalStackview.addArrangedSubview(categoryLabel)
        
        yearLabel.widthAnchor.constraint(equalToConstant: 35).isActive = true
        
        posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Margin / 2).isActive = true
        posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.Margin / 2).isActive = true
        posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Margin).isActive = true
        posterImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true

        infoVerticalStackview.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: Constants.Margin).isActive = true
        infoVerticalStackview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Margin).isActive = true

        infoVerticalStackview.centerYAnchor.constraint(equalTo: posterImageView.centerYAnchor).isActive = true
    }
}

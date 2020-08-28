//
//  MainMovieCell.swift
//  SwiftMovie
//
//  Created by Lucas Farah on 8/27/20.
//  Copyright © 2020 Lucas Farah. All rights reserved.
//

import UIKit

class MainMovieCell: UITableViewCell {

    struct Constants {
        static let Margin: CGFloat = 16
    }
    
    fileprivate let titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var title: String = "" {
        didSet {
            titleLabel.text = title
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
        addSubview(titleLabel)
        
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Margin).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.Margin).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.Margin).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.Margin).isActive = true
    }
}

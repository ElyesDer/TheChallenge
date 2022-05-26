//
//  MovieCollectionViewCell.swift
//  TheChallenge
//
//  Created by Derouiche Elyes on 20/05/2022.
//

import Foundation
import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {

    static let identifier = "MovieCollectionViewCell"
    
    lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var channelImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var content: Content!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = true
        // setup views
        addSubViewsComponents()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with content: Content) {
        self.content = content
        
        // setup image loading
        setUpViews()
    }
}

extension MovieCollectionViewCell: ViewConstraintAutoLayoutSetup {
    
    func addSubViewsComponents() {
        movieImageView.addSubview(channelImage)
        addSubview(movieImageView)
    }
    
    func setUpConstraints() {
        channelImage.anchor(top: nil, leading: nil, bottom: movieImageView.bottomAnchor, trailing: movieImageView.trailingAnchor,
                            padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        NSLayoutConstraint.activate([
            channelImage.widthAnchor.constraint(equalToConstant: 56),
            channelImage.heightAnchor.constraint(equalToConstant: 56),
        ])
        
        movieImageView.fillSuperview()
    }
    
    func setUpViews() {
        movieImageView.kf.setImage(with: URL(string: content.urlImage),
                                   placeholder: UIImage(named: "placeholder")!)
        
        channelImage.kf.setImage(with: URL(string: content.urlLogoChannel),
                                   placeholder: UIImage(named: "placeholder")!)
    }
}

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
        addSubview(movieImageView)
    }
    
    func setUpConstraints() {
        movieImageView.fillSuperview()
    }
    
    func setUpViews() {
        movieImageView.kf.setImage(with: URL(string: content.urlImage),
                                   placeholder: UIImage(named: "placeholder")!)
    }
}

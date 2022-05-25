//
//  HeaderView.swift
//  TheChallenge
//
//  Created by Derouiche Elyes on 24/05/2022.
//

import Foundation
import UIKit

class HeaderView: UIView {
    
    let titleHeader = "Welcome"
    
    lazy var headerLabel: UILabel = {
        var label = UILabel()
        label.text = titleHeader
        label.textColor = UIColor(named: "primaryColor")
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 35, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        addSubViewsComponents()
        setUpConstraints()
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HeaderView: ViewConstraintAutoLayoutSetup {
    func addSubViewsComponents() {
        self.addSubview(headerLabel)
    }
    
    func setUpConstraints() {
        headerLabel.anchor(top: self.topAnchor,
                           leading: self.leadingAnchor,
                           bottom: nil,
                           trailing: nil,
                           padding: .init(top: 80, left: 12, bottom: 0, right: 0))
    }
    
    func setUpViews() {
    }
    
}

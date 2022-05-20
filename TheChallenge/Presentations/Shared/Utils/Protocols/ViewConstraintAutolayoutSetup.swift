//
//  ViewConstraintAutolayoutSetup.swift
//  TheChallenge
//
//  Created by Derouiche Elyes on 20/05/2022.
//

import Foundation

/// This procol serves as guide to setup UIView implementing AutoLayout constraints
protocol ViewConstraintAutoLayoutSetup {
    func addSubViewsComponents()
    func setUpConstraints()
    func setUpViews()
}

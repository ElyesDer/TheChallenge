//
//  UIViewController+.swift
//  TheChallenge
//
//  Created by Derouiche Elyes on 25/05/2022.
//

import Foundation
import UIKit

extension UIViewController {
    var topbarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
}

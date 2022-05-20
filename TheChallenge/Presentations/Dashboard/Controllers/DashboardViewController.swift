//
//  DashboardViewController.swift
//  TheChallenge
//
//  Created by Derouiche Elyes on 20/05/2022.
//

import UIKit

class DashboardViewController: UIViewController {

    var contentView: UIView = {
       let uiView = UIView()
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .darkGray
    }
}

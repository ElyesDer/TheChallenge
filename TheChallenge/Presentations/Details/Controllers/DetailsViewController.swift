//
//  DetailsViewController.swift
//  TheChallenge
//
//  Created by Derouiche Elyes on 21/05/2022.
//

import UIKit
import Combine

class DetailsViewController: UIViewController {
    
    lazy var imageHeader: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var containerView: UIView = {
        let uiView = UIView()
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    lazy var detailsView: UIView = {
        let uiView = UIView()
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    lazy var imagePreview: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.6
        label.sizeToFit()
        label.font = .boldSystemFont(ofSize: 22)
//        label.backgroundColor = .white.withAlphaComponent(0.7)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var subDetailsLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var castLabelSection: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var castLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptionLabelSection: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.isScrollEnabled = true
        scrollView.backgroundColor = .systemBackground
        return scrollView
    }()
    
    var viewModel: DetailsViewModel!

    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup Binding
        bind(to: viewModel)
        
        // run viewDidLoad
        viewModel.viewDidLoad()

        // Do any additional setup after loading the view.
        addSubViewsComponents()
        setUpConstraints()
        setUpViews()
    }
    
    private func bind(to viewModel: DetailsViewModel) {
        viewModel
            .$movie
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] _ in
                self?.setUpViews()
            })
            .store(in: &cancellables)
        
        viewModel
            .$loadingState
            .receive(on: RunLoop.main)
            .sink { value in
                switch value {
                    case .failed(let errorDescription):
                        let alert = UIAlertController(title: "Error loading content", message: "Content load content from server with error \(errorDescription)", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { _ in
                            self.navigationController?.popViewController(animated: true)
                        }))
                        self.present(alert, animated: true, completion: nil)
                    default: break
                }
            }
            .store(in: &cancellables)
        
    }
    
}

extension DetailsViewController: ViewConstraintAutoLayoutSetup {
    func addSubViewsComponents() {
        
        view.addSubview(scrollView)
        
        containerView.addSubview(imageHeader)
        scrollView.addSubview(containerView)
        containerView.addSubview(imagePreview)
        
        containerView.addSubview(imageHeader)
        detailsView.addSubview(imagePreview)
        containerView.addSubview(detailsView)

        containerView.addSubview(titleLabel)
        containerView.addSubview(subDetailsLabel)
        containerView.addSubview(castLabelSection)
        containerView.addSubview(castLabel)
        containerView.addSubview(descriptionLabelSection)
        containerView.addSubview(descriptionLabel)
        
    }
    
    func setUpConstraints() {
        
        // Setup scrollView Constraint
        scrollView.anchor(top: view.topAnchor,
                          leading: view.leadingAnchor,
                          bottom: view.bottomAnchor,
                          trailing: view.trailingAnchor)
        
        //         setup contentView
        containerView.anchor(top: scrollView.topAnchor,
                             leading: scrollView.leadingAnchor,
                             bottom: scrollView.bottomAnchor,
                             trailing: scrollView.trailingAnchor)
        
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        // setup Flexible Image header
        imageHeader.anchor(top: view.topAnchor,
                           leading: containerView.leadingAnchor,
                           bottom: detailsView.topAnchor,
                           trailing: containerView.trailingAnchor)
        
        let headerConstraint = imageHeader.topAnchor.constraint(equalTo: scrollView.topAnchor)
        headerConstraint.priority = UILayoutPriority(999)
        NSLayoutConstraint.activate([
            headerConstraint
        ])

        // setup Subviews
        titleLabel.anchor(top: imagePreview.topAnchor,
                          leading: imagePreview.trailingAnchor,
                          bottom: nil,
                          trailing: containerView.trailingAnchor,
                          padding: .init(top: 4, left: 16, bottom: 8, right: 4)
        )
        
        subDetailsLabel.anchor(top: titleLabel.bottomAnchor,
                               leading: imagePreview.trailingAnchor,
                               bottom: imagePreview.bottomAnchor,
                               trailing: containerView.trailingAnchor,
                               padding: .init(top: 8, left: 16, bottom: 8, right: 8))
        
        castLabelSection.anchor(top: imagePreview.bottomAnchor,
                                leading: containerView.leadingAnchor,
                                bottom: nil,
                                trailing: containerView.trailingAnchor,
                                padding: .init(top: 8, left: 16, bottom: 8, right: 16))
        
        castLabel.anchor(top: castLabelSection.bottomAnchor,
                                leading: containerView.leadingAnchor,
                                bottom: nil,
                                trailing: containerView.trailingAnchor,
                                padding: .init(top: 8, left: 16, bottom: 8, right: 16))
        
        descriptionLabelSection.anchor(top: castLabel.bottomAnchor,
                                leading: containerView.leadingAnchor,
                                bottom: nil,
                                trailing: containerView.trailingAnchor,
                                padding: .init(top: 8, left: 16, bottom: 8, right: 16))
        
        descriptionLabel.anchor(top: descriptionLabelSection.bottomAnchor,
                          leading: containerView.leadingAnchor,
                          bottom: containerView.bottomAnchor,
                          trailing: containerView.trailingAnchor,
                          padding: .init(top: 8, left: 16, bottom: 8, right: 16))
        
        detailsView.anchor(top: scrollView.topAnchor,
                           leading: containerView.leadingAnchor,
                           bottom: nil,
                           trailing: containerView.trailingAnchor,
                           padding: .init(top: 200, left: 0, bottom: 0, right: 0)
        )

        imagePreview.anchor(top: detailsView.topAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: nil,
                            padding: .init(top: -50, left: 16, bottom: 0, right: 0))

        NSLayoutConstraint.activate([
            imagePreview.widthAnchor.constraint(equalToConstant: 120),
            imagePreview.heightAnchor.constraint(equalToConstant: 160)
        ])
        
    }
    
    func setUpViews() {
        
        // setup image loading
        imagePreview.image = .init(named: "placeholder")
        
        // setup image loading
        imageHeader.image = .init(named: "placeholder")
        
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        
        subDetailsLabel.attributedText = NSAttributedString(attributedString: .init(string: viewModel.subdetails ?? ""))
        
        castLabelSection.text = "Cast"
        castLabel.text = viewModel.cast
        descriptionLabelSection.text = "Description"
        descriptionLabel.text = viewModel.description
        
        
    }
    
}


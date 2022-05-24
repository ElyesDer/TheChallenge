//
//  DetailsViewController.swift
//  TheChallenge
//
//  Created by Derouiche Elyes on 21/05/2022.
//

import UIKit
import Combine
import SwiftUI

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
    
    lazy var castContainer: UIView = {
        let uiView = UIView()
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
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
    
    lazy var subInfoStack: UIStackView = {
        let stackView: UIStackView = .init(frame: .zero)
        stackView.spacing = 2
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        
        return stackView
    }()
    
    var parentalView: UIView?
    var formatView: UIView?
    var castView: UIView?
    var reviewView: UIView?
    
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
                        let alert = UIAlertController(title: "Error loading content", message: "Content loaded from server with error \(errorDescription)", preferredStyle: UIAlertController.Style.alert)
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
        
        containerView.addSubview(imageHeader)
        containerView.addSubview(detailsView)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(subDetailsLabel)
        
        containerView.addSubview(castLabelSection)
        //        containerView.addSubview(castLabel)
        containerView.addSubview(descriptionLabelSection)
        containerView.addSubview(descriptionLabel)
        
        containerView.addSubview(castContainer)
        
        imageHeader.addSubview(subInfoStack)
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
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: imageHeader.centerXAnchor),
            subDetailsLabel.centerXAnchor.constraint(equalTo: imageHeader.centerXAnchor)
        ])
        
        titleLabel.anchor(top: nil,
                          leading: nil,
                          bottom: subDetailsLabel.topAnchor,
                          trailing: nil,
                          padding: .init(top: 4, left: 0, bottom: 4, right: 0)
        )
        
        subDetailsLabel.anchor(top: nil,
                               leading: nil,
                               bottom: imageHeader.bottomAnchor,
                               trailing: nil,
                               padding: .init(top: 4, left: 0, bottom: 42, right: 0))
        
        castLabelSection.anchor(top: imageHeader.bottomAnchor,
                                leading: containerView.leadingAnchor,
                                bottom: nil,
                                trailing: containerView.trailingAnchor,
                                padding: .init(top: 8, left: 16, bottom: 8, right: 16))
        
        castContainer.anchor(top: castLabelSection.bottomAnchor,
                             leading: containerView.leadingAnchor,
                             bottom: nil,
                             trailing: containerView.trailingAnchor,
                             padding: .init(top: 8, left: 16, bottom: 8, right: 16))
        
        descriptionLabelSection.anchor(top: castContainer.bottomAnchor,
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
                           padding: .init(top: 250, left: 0, bottom: 0, right: 0)
        )
        
        subInfoStack.anchor(top: nil,
                            leading: nil,
                            bottom: imageHeader.bottomAnchor,
                            trailing: nil,
                            padding: .init(top: 0, left: 0, bottom: 8, right: 0)
        )
        
        // setup height constraint
        NSLayoutConstraint.activate([
            castContainer.heightAnchor.constraint(equalToConstant: 450),
            subInfoStack.heightAnchor.constraint(equalToConstant: 30),
            
            subInfoStack.centerXAnchor.constraint(equalTo: imageHeader.centerXAnchor)
        ])
        
    }
    
    func setUpViews() {
        // setup image loading
        imageHeader.image = .init(named: "placeholder")
        
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        
        subDetailsLabel.attributedText = NSAttributedString(attributedString: .init(string: viewModel.subdetails ?? ""))
        
        castLabelSection.text = "Cast"
        descriptionLabelSection.text = "Description"
        descriptionLabel.text = viewModel.description
        
        if let personnalities = viewModel.movie?.personnalities {
            castView = buildCastView(with: personnalities).view
            if let castView = castView {
                castContainer.addSubview(castView)
                // setup constraint
                castView.fillSuperview()
            }
        }
        
        // setup subInfoStack
        
        parentalView = buildParentalRatingView()
        if let parentalView = parentalView {
            containerView.addSubview(parentalView)
            
            parentalView.anchor(top: titleLabel.topAnchor,
                                leading: titleLabel.trailingAnchor,
                                bottom: titleLabel.bottomAnchor, trailing: nil,
                                padding: .init(top: 0, left: 12, bottom: 0, right: 0))
        }
        
        formatView = buildFormatView()
        if let formatView = formatView {
            subInfoStack.addArrangedSubview(formatView)
        }
        
        reviewView = buildReviewView()?.view
        if let reviewView = reviewView {
            containerView.addSubview(reviewView)
            
            // setup constraints
            
            reviewView.anchor(top: descriptionLabel.bottomAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor)
            
            NSLayoutConstraint.activate([
                reviewView.heightAnchor.constraint(equalToConstant: 170)
            ])
            
        }
        
    }
    
    func buildReviewView() -> UIHostingController<ReviewView>? {
        guard let review = self.viewModel.movie?.reviews else { return nil }
        let reviewView = ReviewView(reviews: review)
        
        return UIHostingController(rootView: reviewView)
    }
    
    func buildFormatView() -> UIView? {
        guard let format = self.viewModel.movie?.formats else { return nil }
        let formatView = FormatsView()
        formatView.setup(with: format)
        return formatView
    }
    
    func buildCastView(with personnalities: [Personnality]) -> UIHostingController<CastView> {
        let castView = CastView(personnalities: personnalities)
        let castHostView = UIHostingController(rootView: castView)
        return castHostView
    }
    
    func buildParentalRatingView() -> UIStackView {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.spacing = 2
        
        viewModel.movie?.parentalRatings.forEach({ parentalRating in
            let label = UILabel(frame: .zero)
            label.text = parentalRating.authority + " - " + parentalRating.value
            label.layer.borderWidth = 1.5
            stackView.addArrangedSubview(label)
        })
        
        return stackView
    }
    
}

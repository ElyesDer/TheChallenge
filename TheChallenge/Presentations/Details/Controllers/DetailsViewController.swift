//
//  DetailsViewController.swift
//  TheChallenge
//
//  Created by Derouiche Elyes on 21/05/2022.
//

import UIKit
import Combine
import SwiftUI
import AVFoundation
import AVKit
import Kingfisher

class DetailsViewController: UIViewController {
    
    lazy var imageHeader: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var containerView: UIView = {
        let uiView = UIView()
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.minimumScaleFactor = 0.6
        label.sizeToFit()
        label.font = .boldSystemFont(ofSize: 24)
        //        label.backgroundColor = .white.withAlphaComponent(0.7)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var subDetailsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.sizeToFit()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
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
    
    lazy var trailerButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.red // (named: "bgBlue")
        button.setTitle("Play trailer", for: .normal)
        return button
    }()
    
    lazy var headerView: UIView = {
        let view = UIView(frame: .zero)
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.layer.opacity = 0.6
        view.addSubview(blurEffectView)
        
        return view
    }()
    
    var descriptionConstraint: NSLayoutConstraint!
    
    lazy var dynamicView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var dynamicButtonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var headerContentStack: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.spacing = 6
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fill
        
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.layer.opacity = 0.6
        blurEffectView.roundCorners(corners: [.topLeft, .topRight], radius: 20)
        stackView.addSubview(blurEffectView)
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
                        let alert = UIAlertController(title: "Error loading content",
                                                      message: "Content loaded from server with error \(errorDescription)", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { _ in
                            self.navigationController?.popViewController(animated: true)
                        }))
                        self.present(alert, animated: true, completion: nil)
                    default: break
                }
            }
            .store(in: &cancellables)
        
    }
    
    @objc
    func launchTrailer() {
        // use this self.viewModel.movie?.trailerURL
        if let trailerURL = self.viewModel.movie?.trailerURL {
            
            let videoURL = URL(string: trailerURL)
            let player = AVPlayer(url: videoURL!)
            
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
        }
    }
    
    @objc
    func didPressShareButton() {
        var shareItems: [Any] = ["Check out this one, Looks interesting for you"]
        if let shareUrl = self.viewModel.movie?.sharingURL, let url = URL(string: shareUrl) {
            shareItems.append(url)
        } else if let trailerURL = self.viewModel.movie?.trailerURL, let url = URL(string: trailerURL) {
            shareItems.append(url)
        }
        
        let shareController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        present(shareController, animated: true)
    }
}

extension DetailsViewController: ViewConstraintAutoLayoutSetup {
    func addSubViewsComponents() {
        
        view.addSubview(scrollView)
        
        containerView.addSubview(imageHeader)
        scrollView.addSubview(containerView)
        
        imageHeader.addSubview(headerContentStack)
        
        containerView.addSubview(dynamicButtonView)
        containerView.addSubview(castLabelSection)
        
        containerView.addSubview(descriptionLabelSection)
        containerView.addSubview(descriptionLabel)
        
        containerView.addSubview(castContainer)
        
        containerView.addSubview(dynamicView)
    }
    
    func setUpConstraints() {
        
        // Setup scrollView Constraint
        scrollView.fillSuperview()
        
        //         setup contentView
        containerView.anchor(top: scrollView.topAnchor,
                             leading: scrollView.leadingAnchor,
                             bottom: scrollView.bottomAnchor,
                             trailing: scrollView.trailingAnchor,
                             padding: .init(top: 300, left: 0, bottom: 0, right: 0))
        
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        // setup Flexible Image header
        imageHeader.anchor(top: nil,
                           leading: containerView.leadingAnchor,
                           bottom: containerView.topAnchor,
                           trailing: containerView.trailingAnchor)
        
        let headerConstraint = imageHeader.topAnchor.constraint(equalTo: view.topAnchor)
        headerConstraint.priority = UILayoutPriority(999)
        NSLayoutConstraint.activate([
            headerConstraint
        ])
        
        headerContentStack.anchor(top: nil, leading: imageHeader.leadingAnchor, bottom: imageHeader.bottomAnchor, trailing: imageHeader.trailingAnchor,
                                  padding: .init(top: 0, left: 0, bottom: 8, right: 0)
        )
        
        dynamicButtonView.anchor(top: imageHeader.bottomAnchor,
                                 leading: containerView.leadingAnchor,
                                 bottom: castLabelSection.topAnchor,
                                 trailing: containerView.trailingAnchor,
                                 padding: .init(top: 0, left: 0, bottom: 16, right: 0))
        
        castLabelSection.anchor(top: dynamicButtonView.bottomAnchor,
                                leading: containerView.leadingAnchor,
                                bottom: nil,
                                trailing: containerView.trailingAnchor,
                                padding: .init(top: 16, left: 16, bottom: 8, right: 16))
        
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
                                bottom: dynamicView.topAnchor,
                                trailing: containerView.trailingAnchor,
                                padding: .init(top: 8, left: 16, bottom: 24, right: 16))
        
        dynamicView.anchor(top: descriptionLabel.bottomAnchor,
                           leading: containerView.leadingAnchor,
                           bottom: containerView.bottomAnchor,
                           trailing: containerView.trailingAnchor,
                           padding: .init(top: 24, left: 0, bottom: 8, right: 16)
        )
        
        // setup height constraint
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            subDetailsLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    
    func setUpViews() {
        // setup image loading
        imageHeader.kf.setImage(with: URL(string: viewModel.imageHeader ?? ""),
                                   placeholder: UIImage(named: "placeholder")!)
        
        titleLabel.text = viewModel.title
        subDetailsLabel.text = viewModel.subdetails
        
        // setup header stackview
        headerContentStack.addArrangedSubview(titleLabel)
        headerContentStack.addArrangedSubview(subDetailsLabel)
        
        castLabelSection.text = "Cast"
        descriptionLabelSection.text = "Description"
        descriptionLabel.text = viewModel.description
        
        if let personnalities = viewModel.movie?.personnalities {
            castView = buildCastView(with: personnalities).view
            if let castView = castView {
                castContainer.addSubview(castView)
                // setup constraint
                castView.fillSuperview()
                
                // compute height
                var dynamicHeight: CGFloat = 0
                personnalities.forEach { personnality in
                    if !personnality.personnalitiesList.isEmpty {
                        dynamicHeight += 110
                    }
                }
                
                NSLayoutConstraint.activate([
                    castContainer.heightAnchor.constraint(equalToConstant: dynamicHeight)
                ])
            }
        }
        
        // setup subInfoStack
        
        parentalView = buildParentalRatingView()
        if let parentalView = parentalView {
            containerView.addSubview(parentalView)
            
            parentalView.anchor(top: headerContentStack.topAnchor,
                                leading: headerContentStack.trailingAnchor,
                                bottom: nil, trailing: nil,
                                padding: .init(top: 0, left: 12, bottom: 0, right: 0))
        }
        
        formatView = buildFormatView()
        if let formatView = formatView {
            subInfoStack.addArrangedSubview(formatView)
            headerContentStack.addArrangedSubview(subInfoStack)
        }
        
        reviewView = buildReviewView()?.view
        if let reviewView = reviewView {
            dynamicView.addSubview(reviewView)
            reviewView.fillSuperview()
        }
        
        // Setup player
        if self.viewModel.movie?.trailerURL != nil {
            // setup gesture
            trailerButton.addTarget(self, action: #selector(launchTrailer), for: .touchUpInside)
            // add button to the hierachy
            
            dynamicButtonView.addSubview(trailerButton)
            trailerButton
                .fillSuperview()
            
            // setup constraint
            NSLayoutConstraint.activate([
                dynamicButtonView.heightAnchor.constraint(equalToConstant: 50),
                trailerButton.widthAnchor.constraint(equalTo: containerView.widthAnchor)
            ])
        }
        
        // Setup share button
        let rightButton: UIBarButtonItem = UIBarButtonItem(image: .init(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(didPressShareButton))
        self.navigationItem.rightBarButtonItem = rightButton
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
            let label = PaddingLabel(withInsets: 4, 4, 4, 4)
            label.text = parentalRating.authority + " - " + parentalRating.value
            label.layer.borderWidth = 1.5
            label.layer.borderColor = UIColor.white.cgColor
            label.textAlignment = .center
            label.textColor = .white
            stackView.addArrangedSubview(label)
        })
        
        return stackView
    }
    
}

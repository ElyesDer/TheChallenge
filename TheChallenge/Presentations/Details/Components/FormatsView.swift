//
//  FormatsView.swift
//  TheChallenge
//
//  Created by Derouiche Elyes on 22/05/2022.
//

import UIKit

class FormatsView: UIView {

    lazy var contentStack: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    var borederedLabel: PaddingLabel {
        let label: PaddingLabel = .init(withInsets: 4, 4, 4, 4)
        label.layer.borderWidth = 1.5
        label.layer.borderColor = UIColor.white.cgColor
        label.textAlignment = .center
        label.textColor = .white
        return label
    }
    
    var normaleLabel: PaddingLabel {
        let label: PaddingLabel = .init(withInsets: 3, 3, 3, 3)
        return label
    }

    var format: Formats!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViewsComponents()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with format: Formats) {
        self.format = format
        setUpViews()
    }
}

extension FormatsView: ViewConstraintAutoLayoutSetup {
    func setUpViews() {
        
        if !format.video.isEmpty {
//            let videoLabel = normaleLabel
//            videoLabel.text = "Video"
//
//            contentStack.addArrangedSubview(videoLabel)
            format.video.forEach { videoItem in
                let itemLabel = borederedLabel
                itemLabel.text = videoItem
                contentStack.addArrangedSubview(itemLabel)
            }
        }
        
        if !format.audio.isEmpty {
//            let audioLabel = normaleLabel
//            audioLabel.text = "Audio"
//
//            contentStack.addArrangedSubview(audioLabel)
            format.audio.forEach { audioItem in
                let itemLabel = borederedLabel
                itemLabel.text = audioItem
                contentStack.addArrangedSubview(itemLabel)
            }
        }
    }
    
    func addSubViewsComponents() {
        self.addSubview(contentStack)
    }
    
    internal func setUpConstraints() {
        contentStack.fillSuperview()
    }
}

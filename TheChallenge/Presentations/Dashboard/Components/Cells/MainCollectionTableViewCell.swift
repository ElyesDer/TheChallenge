//
//  RowCollectionViewCell.swift
//  TheChallenge
//
//  Created by Derouiche Elyes on 20/05/2022.
//

import Foundation
import UIKit

class MainCollectionDiffableDataSource: UICollectionViewDiffableDataSource<Int, Content> {}

class MainCollectionTableViewCell: UITableViewCell {

    static let identifier = "MainCollectionTableViewCell"
    
    lazy var collectionView: UICollectionView = {
        // setting up horizental layout
        
        let layout = UICollectionViewFlowLayout()
        //        layout.estimatedItemSize = CGSize(width: 70, height: 100)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = true
        collectionView.contentInset = .init(top: 0, left: 10, bottom: 0, right: 0)
        collectionView.delegate = self
        collectionView.isUserInteractionEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var contents: [Content] = []
    
    var diffableDataSource: MainCollectionDiffableDataSource!
    
    func setup(with content: [Content]) {
        self.contents = content
        
        addSubViewsComponents()
        setUpConstraints()
        setUpViews()
        buildAndApplySnapshot()
    }
    
    func setupCollectionView() {
        self.contentView.isUserInteractionEnabled = false
        collectionView.delegate = self
        
        // register
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        
        diffableDataSource = MainCollectionDiffableDataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: MovieCollectionViewCell.identifier,
                    for: indexPath) as? MovieCollectionViewCell
                cell?.setup(with: item)
                return cell
            })
    }
    
    func buildAndApplySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Content>()
        snapshot.appendSections([0])
        snapshot.appendItems(self.contents)
        diffableDataSource.apply(snapshot, animatingDifferences: false)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension MainCollectionTableViewCell: ViewConstraintAutoLayoutSetup {
    func addSubViewsComponents() {
        self.addSubview(collectionView)
    }
    
    func setUpConstraints() {
        collectionView.fillSuperview()
    }
    
    func setUpViews() {
        setupCollectionView()
    }
}

extension MainCollectionTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 140, height: 180)
    }
}
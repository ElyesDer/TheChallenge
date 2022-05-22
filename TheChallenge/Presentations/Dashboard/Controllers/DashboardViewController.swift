//
//  DashboardViewController.swift
//  TheChallenge
//
//  Created by Derouiche Elyes on 20/05/2022.
//

import UIKit
import Combine

protocol GenericViewGestureHandler: AnyObject {
    func showDetails (content: Content)
    func showInfo(content: Content)
}

class DashboardViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        return tableView
    }()
    
    private lazy var refreshControl = {
        return UIRefreshControl()
    }()
    
    let viewModel: DashboardViewModel!
    private var cancellables = Set<AnyCancellable>()
    
    private var diffableDataSource: DashboardTableViewDiffableDataSource!
    
    init(viewModel: DashboardViewModel = DashboardViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addSubViewsComponents()
        setUpConstraints()
        setUpViews()
        bind(to: viewModel)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.load()
    }

    private func bind(to viewModel: DashboardViewModel) {
        viewModel
            .$structuredRowProvider
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] _ in
                self?.buildAndApplySnapshot()
                self?.refreshControl.endRefreshing()
            })
            .store(in: &cancellables)
    }
}

extension DashboardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let configuration = self.viewModel.structuredRowProvider[indexPath.section].row.getRessource().configuration
        if let height = configuration.size?.height {
            return height
        }
        return UIScreen.main.bounds.height
    }
}

extension DashboardViewController: ViewConstraintAutoLayoutSetup {
    func addSubViewsComponents() {
        view.addSubview(tableView)
    }
    
    internal func setUpConstraints() {
        tableView.fillSuperview()
    }
    
    internal func setUpViews() {
        setupTableView()
    }
    
    fileprivate func setupTableView() {
        self.tableView.delegate = self
        
        // register cells
        ContentRow.allCases.forEach { contentRow in
            let ressource = contentRow.getRessource()
            tableView.register(ressource.class, forCellReuseIdentifier: ressource.id)
        }
        
        // register for delegate, diffableDataSource
        diffableDataSource = DashboardTableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            
            let rowRessource = self.viewModel.structuredRowProvider[indexPath.section].row.getRessource()
            
            switch rowRessource.type {
                case is MainCollectionTableViewCell.Type : do {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: MainCollectionTableViewCell.identifier) as? MainCollectionTableViewCell else { return UITableViewCell() }
                    cell.setup(with: self.viewModel.structuredRowProvider[indexPath.section].content, gestureDelegate: self)
                    return cell
                }
                default : do {
                    // default
                    fatalError("Unknown or unimplemented Ressource")
                }
            }
        })
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func buildAndApplySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<ContentRow, [Content]>()
        
        snapshot.appendSections(Array(Set(viewModel.structuredRowProvider.map { $0.row })))
        viewModel.structuredRowProvider.forEach { structuredModel in
            snapshot.appendItems([structuredModel.content], toSection: structuredModel.row)
        }
        
        diffableDataSource.apply(snapshot, animatingDifferences: false)
    }
    
    @objc
    func refreshData() { }
}

extension DashboardViewController: GenericViewGestureHandler {

    func showDetails (content: Content) {
        let detailsVC = DetailsViewController()
        detailsVC.viewModel = .init(from: content.onClick.urlPage)
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func showInfo(content: Content) {
        
    }
    
}

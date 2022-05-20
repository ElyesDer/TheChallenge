//
//  MainTableViewCell.swift
//  TheChallenge
//
//  Created by Derouiche Elyes on 20/05/2022.
//

import Foundation
import UIKit

class DashboardTableViewDiffableDataSource: UITableViewDiffableDataSource<ContentRow, Content> {
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return snapshot().sectionIdentifiers[section].rawValue.uppercased()
    }
}

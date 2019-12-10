//
//  VC-Extension+TableViewDataSource.swift
//  GithubIssues
//
//  Created by Akhil Singh on 08/12/19.
//  Copyright © 2019 Akhil Singh. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UITableView Data Source

extension ViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return issueViewModels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "IssueListingTableViewCell") as? IssueListingTableViewCell else {
            return UITableViewCell()
        }
        
        if let viewModal = issueViewModels?[indexPath.row] {
            guard let vModal = viewModal as? IssueViewModel else{
                return tableViewCell
            }
            tableViewCell.updateDataBasedOnViewModel(vModal)
        }
        return tableViewCell
    }
    
} // end extension ViewController : UITableViewDataSource


extension IssueDetailsViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedIssueViewModel?.comments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "IssueDetailsTableViewCell") as? IssueDetailsTableViewCell else {
            return UITableViewCell()
        }
        
        if let commentViewModel = selectedIssueViewModel?.comments?[indexPath.row] as? CommentViewModel {
            tableViewCell.updateDataBasedOnViewModel(commentViewModel)
        }
        return tableViewCell
    }
}

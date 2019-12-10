//
//  VC-Extension+TableViewDelegate.swift
//  GithubIssues
//
//  Created by Akhil Singh on 08/12/19.
//  Copyright © 2019 Akhil Singh. All rights reserved.
//

import Foundation

import UIKit

// MARK: - UITableView Delegate

extension ViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let viewModel = issueViewModels?[indexPath.row] as? IssueViewModel{
            if viewModel.issue.totalComments > 0{
                self.performSegue(withIdentifier: "listToCommentsSegue", sender: viewModel)
            }
            else{
                let alertController = UIAlertController(title: "Issues", message: "No Comments found for selected Issue", preferredStyle: .alert)
                let okAlert = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okAlert)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
}


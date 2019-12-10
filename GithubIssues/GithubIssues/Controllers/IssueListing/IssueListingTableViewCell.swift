//
//  IssueListingTableViewCell.swift
//  GithubIssues
//
//  Created by Akhil Singh on 09/12/19.
//  Copyright © 2019 Akhil Singh. All rights reserved.
//

import UIKit

class IssueListingTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    @IBOutlet weak var totalCommentsLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateDataBasedOnViewModel(_ issueViewModel:IssueViewModel){
        titleLabel.text = issueViewModel.issueTitle
        totalCommentsLabel.text = issueViewModel.totalComments
        createdDateLabel.text = issueViewModel.createdTime
        descriptionLabel.text = issueViewModel.body
    }
}

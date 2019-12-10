//
//  IssueDetailsTableViewCell.swift
//  GithubIssues
//
//  Created by Akhil Singh on 10/12/19.
//  Copyright © 2019 Akhil Singh. All rights reserved.
//

import UIKit

class IssueDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var authorCommentLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateDataBasedOnViewModel(_ commentViewModel:CommentViewModel){
        authorNameLabel.text = commentViewModel.authorName
        authorCommentLabel.text = commentViewModel.comment
    }
}

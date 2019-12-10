//
//  CommentViewModel.swift
//  GithubIssues
//
//  Created by Akhil Singh on 10/12/19.
//  Copyright © 2019 Akhil Singh. All rights reserved.
//

import Foundation

struct CommentViewModel {
    
    let commentModal: CommentModel
    private(set) var authorName = ""
    private(set) var comment = ""
    
    init(commentModel: CommentModel) {
        self.commentModal = commentModel
        updateProperties()
    }
    
    private mutating func updateProperties() {
        authorName = setNameofAuthor(commentModal)
        comment = setDataForComment(commentModal)
    }
}

extension CommentViewModel {
    
    private func setNameofAuthor(_ commentModal:CommentModel) -> String {
        return "Author Name:- \(commentModal.authorName)"
    }
    
    private func setDataForComment(_ commentModal:CommentModel) -> String {
        return "\(commentModal.authorName)'s Comment:- \(commentModal.comment)"
    }
}

//
//  IssueViewModel.swift
//  GithubIssues
//
//  Created by Akhil Singh on 09/12/19.
//  Copyright © 2019 Akhil Singh. All rights reserved.
//

import Foundation

struct IssueViewModel {
    
    let issue: Issue
    private(set) var issueTitle = ""
    private(set) var totalComments = ""
    private(set) var createdTime = ""
    private(set) var body = ""
    private(set) var comments:NSArray?
    private(set) var comments_url = ""
    
    init(issue: Issue) {
        self.issue = issue
        updateProperties()
    }
    
    mutating func updateComments(commentArray: NSArray){
        comments = setComments(commentsArray: commentArray)
    }
    
    private mutating func updateProperties() {
        issueTitle = setTitleName(issue: issue)
        body = setBody(issue: issue)
        totalComments = setTotalComments(issue: issue)
        createdTime = setCreatedTime(issue: issue)
        comments_url = setComments_url(issue: issue)
    }
}

extension IssueViewModel {
    
    private func setTitleName(issue: Issue) -> String {
        return "Title Name:- \(issue.issueTitle ?? "")"
    }
    
    private func setBody(issue: Issue) -> String {
        if issue.body?.count ?? 0 < 140{
            return "Description:- \(issue.body ?? "")"
        }
        else if let trimmedBody = issue.body?.prefix(140){
            return "Description:- \(trimmedBody)..."
        }
        else{
            return "There is no description!"
        }
    }
    
    private func setTotalComments(issue: Issue) -> String {
        if (issue.totalComments > 1){
            return "There are \(issue.totalComments) comments for this issue."
        }
        else if (issue.totalComments == 1){
            return "There is \(issue.totalComments) comment for this issue."
        }
        return "No comments for this issue"
    }
    
    private func setCreatedTime(issue: Issue) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMMM dd, yyyy"
        
        let date = dateFormatterPrint.string(from: issue.createdTime ?? Date())
        return "Created Date: " + date
    }
    
    private func setComments_url(issue: Issue) -> String {
        return issue.comments_url ?? ""
    }
    
    private func setComments(commentsArray: NSArray) -> NSArray {
        return commentsArray
    }
}


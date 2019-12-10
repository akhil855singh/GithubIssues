//
//  IssueDetailsViewController.swift
//  GithubIssues
//
//  Created by Akhil Singh on 10/12/19.
//  Copyright © 2019 Akhil Singh. All rights reserved.
//

import UIKit

class IssueDetailsViewController: UIViewController {
    
    private let apiManager = APIManager()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dataLoader: UIActivityIndicatorView!
    
    var selectedIssueViewModel:IssueViewModel?
    
    var commentViewModels: NSArray? {
        didSet {
            DispatchQueue.main.async {
                self.updateTableViewWithData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Issue Comments"
        dataLoader.startAnimating()
        createCommentModels()
        // Do any additional setup after loading the view.
    }
}

extension IssueDetailsViewController{
    
    private func createCommentModels(){
        guard let comments = selectedIssueViewModel?.issue.comments as? NSArray else {
            getCommentsFromServer()
            return
        }
        
        if comments.count > 0{
            updateSelectedIssueWithComments()
        }
        else{
            getCommentsFromServer()
        }
        
    }
    
    private func updateSelectedIssueWithComments(){
        let viewModels = NSMutableArray()
        if let comments = selectedIssueViewModel?.issue.comments as? NSArray{
        for comment in comments{
            let commentDict = comment as? NSDictionary
            let userDict = commentDict?.value(forKey: "user") as? NSDictionary
            let commentObject = CommentModel(comment: commentDict?.value(forKey: "body") as? String ?? "", authorName: userDict?.value(forKey: "login") as? String ?? "")
            let commentViewModal = CommentViewModel(commentModel: commentObject)
            viewModels.add(commentViewModal)
            }
        }
        updateCommentViewModels(viewModels)
    }
    
    private func updateCommentViewModels(_ viewModels:NSArray){
        selectedIssueViewModel?.updateComments(commentArray: viewModels)
        commentViewModels = viewModels
    }
    
    private func updateTableViewWithData() {
        dataLoader.stopAnimating()
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    private func getCommentsFromServer() {
        apiManager.getCommentsForIssue(selectedIssueViewModel?.comments_url ?? "") { (commentsArray, error) in
            if let error = error {
                print("Get issues error: \(error.localizedDescription)")
                return
            }
            guard let comments = commentsArray else{
                return
            }
            self.createAndSaveCommentModels(comments)
        }
    }
    
    private func createAndSaveCommentModels(_ commentsArray:NSArray){
        let comments = NSMutableArray()
        for comment in commentsArray {
            guard let commentDict = comment as? NSDictionary else{
                return
            }
            comments.add(commentDict)
        }
        saveCommentToCoreData(comments)
        updateSelectedIssueWithComments()
    }
    
    private func saveCommentToCoreData(_ comments:NSArray){
        let issueToBeSaved = selectedIssueViewModel?.issue
        issueToBeSaved?.comments = comments
        CoreDataStack.saveContext()
    }
}



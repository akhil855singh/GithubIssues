//
//  ViewController.swift
//  GithubIssues
//
//  Created by Akhil Singh on 08/12/19.
//  Copyright © 2019 Akhil Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let apiManager = APIManager()
    @IBOutlet weak var dataLoader: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var issueViewModels: NSArray? {
        didSet {
            DispatchQueue.main.async {
                self.updateTableViewWithData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Github Issues"
        dataLoader.startAnimating()
        checkForNewDataFromServer()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "listToCommentsSegue" {
            
            if let destinationViewController = segue.destination as? IssueDetailsViewController
            {
                let selectedViewModel = sender as? IssueViewModel
                destinationViewController.selectedIssueViewModel = selectedViewModel
            }
        }
    }
}

extension ViewController{
    
    private func loadViewModalsFromDatabase(){
        let viewModels = NSMutableArray()
        let issues = CoreDataStack.getAllIssues()
        for issue in issues{
            let viewModal = IssueViewModel(issue: issue)
            viewModels.add(viewModal)
        }
        updateIssueViewModels(viewModels)
    }
    
    private func updateIssueViewModels(_ viewModels:NSArray){
        issueViewModels = viewModels
    }
    
    private func checkForNewDataFromServer(){
        let currentDate = Date()
        if let savedDate = UserDefaults.standard.value(forKey: "LastRefreshDate") as? Date{
            let calendar = Calendar.current
            let components = calendar.dateComponents([.day,.hour,.minute], from: savedDate, to: currentDate)
            if components.day ?? 0 >= 1{
                getIssuesFromServer()
            }
            else{
                if CoreDataStack.getAllIssues().count > 0{
                    loadViewModalsFromDatabase()
                }
                else{
                    getIssuesFromServer()
                }
            }
        }
        else{
            getIssuesFromServer()
        }
    }
    private func updateTableViewWithData() {
        dataLoader.stopAnimating()
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    private func getIssuesFromServer() {
        apiManager.getIssues { [unowned self] (issueArray, error) in
            //print(issueArray)
            if let error = error {
                print("Get issues error: \(error.localizedDescription)")
                return
            }
            guard let issues = issueArray else{
                return
            }
            UserDefaults.standard.set(Date(), forKey: "LastRefreshDate")
            UserDefaults.standard.synchronize()
            self.createAndSaveIssueModels(issues)
        }
    }
    
    private func createAndSaveIssueModels(_ issueArray:NSArray){
        for issue in issueArray {
            let issueDict = issue as? NSDictionary
            let issueObject = IssueModel(title: issueDict?.value(forKey: "title") as? String ?? "", totalComments: issueDict?.value(forKey: "comments") as? Int ?? 0, comments: nil, createdTime: issueDict?.value(forKey: "created_at") as? String ?? "", body: issueDict?.value(forKey: "body") as? String ?? "", comments_url: issueDict?.value(forKey: "comments_url") as? String ?? "")
            saveIssueToCoreData(issueObject)
            loadViewModalsFromDatabase()
        }
    }
    
    private func saveIssueToCoreData(_ issue:IssueModel){
        let newIssue = Issue(context: CoreDataStack.context)
        newIssue.issueTitle = issue.title
        newIssue.totalComments = Int16(issue.totalComments)
        newIssue.comments = nil
        newIssue.comments_url = issue.comments_url
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatterGet.date(from: issue.createdTime){
            newIssue.createdTime = date
        }
        else{
            newIssue.createdTime = Date()
        }
        newIssue.body = issue.body
        
        CoreDataStack.saveContext()
    }
}


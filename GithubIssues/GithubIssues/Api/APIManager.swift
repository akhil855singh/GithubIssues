//
//  APIManager.swift
//  GithubIssues
//
//  Created by Akhil Singh on 09/12/19.
//  Copyright © 2019 Akhil Singh. All rights reserved.
//

import Foundation

class APIManager {
    let issuesDataURL = "https://api.github.com/repos/firebase/firebase-ios-sdk/issues"

    func getIssues(completion: @escaping (_ issues: NSArray?, _ error: Error?) -> Void) {
        getJSONFromURL(urlString: issuesDataURL) { (issueArray, error) in
            guard let parsedIssues = issueArray, error == nil else {
                print("Failed to get data")
                return completion(nil, error)
            }
            return completion(parsedIssues, nil)
        }
    }
    
    func getCommentsForIssue(_ commentUrl:String, completion: @escaping (_ comments: NSArray?, _ error: Error?) -> Void) {
        getJSONFromURL(urlString: commentUrl) { (comments, error) in
            guard let parsedComments = comments, error == nil else {
                print("Failed to get data")
                return completion(nil, error)
            }
            return completion(parsedComments, nil)
        }
    }

}

extension APIManager {
    private func getJSONFromURL(urlString: String, completion: @escaping (_ issues: NSArray?, _ error: Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Error: Cannot create URL from string")
            return
        }
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            guard error == nil else {
                print("Error calling api")
                return completion(nil, error)
            }
            guard let responseData = data else {
                print("Data is nil")
                return completion(nil, error)
            }
            if let json = try? JSONSerialization.jsonObject(with: responseData, options: []) as? NSArray {
                completion(json, nil)
            }
        }
        task.resume()
    }
}

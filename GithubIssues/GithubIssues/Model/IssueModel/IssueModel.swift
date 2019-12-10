//
//  IssueModel.swift
//  GithubIssues
//
//  Created by Akhil Singh on 09/12/19.
//  Copyright © 2019 Akhil Singh. All rights reserved.
//

struct IssueModel {
    let title: String
    let totalComments: Int
    let comments:[CommentModel]?
    let createdTime: String
    let body:String
    let comments_url:String
}

extension IssueModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        case title
        case totalComments
        case createdTime
        case body
        case comments_url
        case comments
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        totalComments = try values.decodeIfPresent(Int.self, forKey: .totalComments) ?? 0
        createdTime = try values.decode(String.self, forKey: .createdTime)
        body = try values.decodeIfPresent(String.self, forKey: .body) ?? ""
        comments_url = try values.decodeIfPresent(String.self, forKey: .comments_url) ?? ""
        comments = try values.decode([CommentModel].self, forKey: .comments)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(totalComments, forKey: .totalComments)
        try container.encode(createdTime, forKey: .createdTime)
        try container.encodeIfPresent(body, forKey: .body)
        try container.encodeIfPresent(comments_url, forKey: .comments_url)
        try container.encodeIfPresent(comments, forKey: .comments)
    }
}




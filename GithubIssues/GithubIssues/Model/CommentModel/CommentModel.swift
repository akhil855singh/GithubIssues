//
//  CommentModel.swift
//  GithubIssues
//
//  Created by Akhil Singh on 09/12/19.
//  Copyright © 2019 Akhil Singh. All rights reserved.
//

import Foundation

struct CommentModel {
    let comment: String
    let authorName: String
}

extension CommentModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        case comment
        case authorName
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        comment = try values.decodeIfPresent(String.self, forKey: .comment) ?? ""
        authorName = try values.decodeIfPresent(String.self, forKey: .authorName) ?? ""
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(comment, forKey: .comment)
        try container.encodeIfPresent(authorName, forKey: .authorName)
    }
}


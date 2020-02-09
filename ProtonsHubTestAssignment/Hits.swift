//
//  Hits.swift
//  ProtonsHubTestAssignment
//
//  Created by Bushra on 09/02/20.
//  Copyright © 2020 Softinator. All rights reserved.
//

import UIKit

struct Hits: Codable {
    var created_at: String
    var title: String
    var url: String?
    var author: String
    var points: Int
    var story_text: String?
    var comment_text: String?
    var num_comments: Int
    var story_id: String?
    var story_title: String?
    var story_url: String?
    var parent_id: String?
    var created_at_i: Double
    var _tags: [String]
    var objectID: String
    var _highlightResult: Highlights?
}

struct Highlights: Codable {
    var title: SubModule?
    var url: SubModule?
    var author: SubModule?
}

struct SubModule: Codable {
    var value: String?
    var matchLevel: String?
    var matchedWords: [String?]
}

//
//  Story.swift
//  Hacker-news
//
//  Created by Henry Chukwu on 10/2/18.
//  Copyright © 2018 Henry Chukwu. All rights reserved.
//

import Foundation

struct Story: Codable {

    var by: String?
    var descendants: Int?
    var id: Int?
//    var kids: [Int?]
    var score: Int?
    var time: Date
    var title: String
    var type: String?
    var url: String
}

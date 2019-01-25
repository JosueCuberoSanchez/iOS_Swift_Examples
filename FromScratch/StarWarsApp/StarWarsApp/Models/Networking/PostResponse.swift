//
//  PostResponse.swift
//  StarWarsApp
//
//  Created by Josue on 1/24/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation

struct PostResponse: Codable {

    var userId: Int
    var title: String
    var body: String
    var postId: Int

    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case title = "title"
        case body = "body"
        case postId = "id"
    }

}

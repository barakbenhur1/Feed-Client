//
//  Model.swift
//  Feed
//
//  Created by ברק בן חור on 18/05/2023.
//

import UIKit

struct Post: ModelProtocol {
    var geo: String?
    
    var title: String?
    var id: Int?
    var userId: Int?
    let body : String?
    
    enum CodingKeys: String, CodingKey {
        case geo = "geo"
        case userId = "userId"
        case id = "id"
        case title = "title"
        case body = "body"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        geo = try values.decodeIfPresent(String.self, forKey: .geo)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        body = try values.decodeIfPresent(String.self, forKey: .body)
    }
}

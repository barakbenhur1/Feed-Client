//
//  ToDo.swift
//  Feed
//
//  Created by ברק בן חור on 19/05/2023.
//

import UIKit

struct ToDo: ModelProtocol {
    var geo: String?
    
    let userId : Int?
    let id : Int?
    let title : String?
    let completed : Bool?
    
    enum CodingKeys: String, CodingKey {
        case geo = "geo"
        case userId = "userId"
        case id = "id"
        case title = "title"
        case completed = "completed"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        geo = try values.decodeIfPresent(String.self, forKey: .geo)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        completed = try values.decodeIfPresent(Bool.self, forKey: .completed)
    }
}

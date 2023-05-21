//
//  Photo.swift
//  Feed
//
//  Created by ברק בן חור on 19/05/2023.
//

import UIKit

struct Photo: ModelProtocol {
    var geo: String?
    
    var title: String?
    var id: Int?
    var userId: Int?
    
    let albumId : Int?
    let url : String?
    let thumbnailUrl : String?
    
    enum CodingKeys: String, CodingKey {
        case geo = "geo"
        case albumId = "albumId"
        case userId = "userId"
        case id = "id"
        case title = "title"
        case url = "url"
        case thumbnailUrl = "thumbnailUrl"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        geo = try values.decodeIfPresent(String.self, forKey: .geo)
        albumId = try values.decodeIfPresent(Int.self, forKey: .albumId)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        thumbnailUrl = try values.decodeIfPresent(String.self, forKey: .thumbnailUrl)
    }
    
}

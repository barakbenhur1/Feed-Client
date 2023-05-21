//
//  ModelProtocol.swift
//  Feed
//
//  Created by ברק בן חור on 18/05/2023.
//

import UIKit

protocol ModelProtocol: Decodable {
    var title: String? { get }
    var id: Int? { get }
    var userId: Int? { get }
    var geo: String? { get }
}

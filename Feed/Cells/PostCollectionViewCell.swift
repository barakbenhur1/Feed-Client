//
//  TableViewCell.swift
//  Feed
//
//  Created by ברק בן חור on 18/05/2023.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var back: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var body: UILabel!
    
    func set(title: String) {
        self.title.text = title
    }
    
    func set(body: String) {
        self.body.text = body
    }
}

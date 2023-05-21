//
//  ToDoCollectionViewCell.swift
//  Feed
//
//  Created by ברק בן חור on 19/05/2023.
//

import UIKit

class ToDoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var back: UIView!
    @IBOutlet weak var title: UILabel!
    
    func set(title: String) {
        self.title.text = title
    }
}


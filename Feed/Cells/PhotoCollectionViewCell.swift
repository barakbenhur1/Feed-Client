//
//  PhotoCollectionViewCell.swift
//  Feed
//
//  Created by ברק בן חור on 19/05/2023.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var back: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    func set(title: String) {
        self.title.text = title
    }
    
    func set(image: UIImage?) {
        self.image.image = image
    }
}

//
//  NewPhotoViewController.swift
//  Feed
//
//  Created by ברק בן חור on 20/05/2023.
//

import UIKit

class NewPhotoViewController: UIViewController {
    @IBOutlet weak var photoTitle: UITextField!
    @IBOutlet weak var photo: UIImageView!
    
    var viewModel: PhotosViewModel!
    
    var numOfItems = 0
    
    @IBAction func back(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func done(_ sender: UIButton) {
        viewModel.addPhoto(numOfItems: numOfItems, title: photoTitle.text ?? "", image: "https://via.placeholder.com/600/1ee8a4")
        
        dismiss(animated: true)
    }
}

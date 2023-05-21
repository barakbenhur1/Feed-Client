//
//  NewPostViewController.swift
//  Feed
//
//  Created by ברק בן חור on 20/05/2023.
//

import UIKit

class NewPostViewController: UIViewController {
    @IBOutlet weak var postTitle: TextView!
    @IBOutlet weak var postBody: TextView!
    
    var viewModel: PostViewModel!
    
    var numOfItems = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postTitle.placeHolderText = "title"
        postTitle.isBold = true
        postBody.placeHolderText = "body"
        postBody.isBold = false
    }
    
    @IBAction func back(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func done(_ sender: UIButton) {
        viewModel.addPost(numOfItems: numOfItems, title: postTitle.text, body: postBody.text)
        
        dismiss(animated: true)
    }
}

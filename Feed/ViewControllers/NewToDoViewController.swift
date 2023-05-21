//
//  NewToDoViewController.swift
//  Feed
//
//  Created by ברק בן חור on 20/05/2023.
//

import UIKit

class NewToDoViewController: UIViewController {
    @IBOutlet weak var textView: TextView!
    
    var viewModel: ToDoViewModel!
    
    var numOfItems = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.placeHolderText = "To Do..."
        textView.isBold = true
    }
    
    @IBAction func back(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func done(_ sender: UIButton) {
        viewModel.addToDo(numOfItems: numOfItems, title: textView.text)
        
        dismiss(animated: true)
    }
}

//
//  PostViewController.swift
//  Feed
//
//  Created by ברק בן חור on 20/05/2023.
//

import UIKit
import CoreLocation

class PostViewController: UIViewController {
    @IBOutlet weak var postTitle: UITextView!
    @IBOutlet weak var postBody: UITextView!
    
    @IBOutlet weak var editView: InteractionsView!
    
    var viewModel: PostViewModel!
    
    var titleForPost: String!
    var body: String!
    var id: String!
    var userId: String?
    var coord: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postTitle.text = titleForPost
        postBody.text = body
        
        editView.delegate = self
        editView.removeButton.isHidden = userId != "999"
        editView.updateButton.isHidden = userId != "999"
        editView.map.isHidden = coord?.count != 2
    }
    
    func shareOnWhatsApp() {
        let items = [titleForPost, body]
        
        // Create an activity view controller
        let activityViewController = UIActivityViewController(activityItems: items as [Any], applicationActivities: nil)
        
        // Set the activity view controller's completion handler
        activityViewController.completionWithItemsHandler = { activityType, completed, returnedItems, error in
            if completed {
                // Sharing completed
                print("Sharing on WhatsApp completed")
            } else {
                // Sharing canceled
                print("Sharing on WhatsApp canceled")
            }
        }
        
        // Set the excluded activity types if desired
        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook]
        
        // Present the activity view controller
        present(activityViewController, animated: true, completion: nil)
    }
}

extension PostViewController: InteractionsViewDelegate {
    func map() {
        guard let coord = coord, coord.count == 2 else { return }
        let map = MapViewController()
        map.coord = CLLocationCoordinate2D(latitude: CLLocationDegrees(coord[0])!, longitude: CLLocationDegrees(coord[1])!)
        map.modalPresentationStyle = .fullScreen
        present(map, animated: true)
    }
    
    func back() {
        dismiss(animated: true)
    }
    
    func remove() {
        viewModel.removePost(id: id)
        dismiss(animated: true)
    }
    
    func update() {
        viewModel.updatePost(id: id, title: postTitle.text, body: postBody.text)
        dismiss(animated: true)
    }
    
    func shere() {
        shareOnWhatsApp()
    }
}

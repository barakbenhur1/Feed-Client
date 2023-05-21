//
//  ToDoViewController.swift
//  Feed
//
//  Created by ברק בן חור on 20/05/2023.
//

import UIKit
import CoreLocation

class ToDoViewController: UIViewController {
    @IBOutlet weak var toDoTitle: UITextView!
    @IBOutlet weak var editView: InteractionsView!
    
    var viewModel: ToDoViewModel!
    
    var toDo: String!
    var id: String!
    var userId: String!
    var coord: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toDoTitle.text = toDo
        editView.delegate = self
        editView.removeButton.isHidden = userId != "999"
        editView.updateButton.isHidden = userId != "999"
    }
    
    func shareOnWhatsApp() {
        let items = [toDo]
        
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

extension ToDoViewController: InteractionsViewDelegate {
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
        viewModel.removeToDo(id: id)
        dismiss(animated: true)
    }
    
    func update() {
        viewModel.updateToDo(id: id, title: toDoTitle.text)
        dismiss(animated: true)
    }
    
    func shere() {
        shareOnWhatsApp()
    }
}

//
//  UserViewController.swift
//  Feed
//
//  Created by ברק בן חור on 20/05/2023.
//

import UIKit
import CoreLocation

class UserViewController: UIViewController {
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var userNameLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var phoneLabel: UITextField!
    @IBOutlet weak var websiteLabel: UITextField!
    @IBOutlet weak var streetLabel: UITextField!
    @IBOutlet weak var suiteLabel: UITextField!
    @IBOutlet weak var cityLabel: UITextField!
    @IBOutlet weak var zipCodeLabel: UITextField!
    @IBOutlet weak var geoLabel: UITextField!
    
    @IBOutlet weak var companyNameLabel: UITextField!
    @IBOutlet weak var companyCatchPhraseLabel: UITextField!
    @IBOutlet weak var companyBsLabel: UITextField!
    
    @IBOutlet weak var editView: InteractionsView!
    
    var viewModel: UsersViewModel!
    
    var name: String!
    ,userName: String!
    ,email: String!
    ,phone: String!
    ,website: String!
    ,street: String!
    ,suite: String!
    ,city: String!
    ,zipCode: String!
    ,geo: String!
    ,companyName: String!
    ,companyCatchPhrase: String!
    ,companyBs: String!
    
    var id: String!
    var userId: String?
    var coord: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = name
        userNameLabel.text = userName
        emailLabel.text = email
        phoneLabel.text = phone
        websiteLabel.text = website
        streetLabel.text = street
        suiteLabel.text = suite
        cityLabel.text = city
        zipCodeLabel.text = zipCode
        geoLabel.text = geo
        companyNameLabel.text = companyName
        companyCatchPhraseLabel.text = companyCatchPhrase
        companyBsLabel.text = companyBs
        
        editView.delegate = self
        editView.removeButton.isHidden = userId != "999"
        editView.updateButton.isHidden = userId != "999"
    }
    
    func shareOnWhatsApp() {
        let items = [name, userName, email, phone, website, street, suite, city, zipCode, geo, companyName, companyCatchPhrase, companyBs]
        
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

extension UserViewController: InteractionsViewDelegate {
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
        viewModel.removeUser(id: id)
        dismiss(animated: true)
    }
    
    func update() {
        let geo: [String] = {
            let comp = geoLabel.text?.components(separatedBy: ",")
            return (comp == nil || comp?.count != 2) ? ["", ""] : comp!
        }()
        viewModel.updateUser(id: id, name: nameLabel.text ?? "", username: userNameLabel.text ?? "", email: emailLabel.text ?? "", street: streetLabel.text ?? "", suite: suiteLabel.text ?? "", city: cityLabel.text ?? "", zipcode: zipCodeLabel.text ?? "", lat: geo[0] , lng: geo[1], phone: phoneLabel.text ?? "", website: websiteLabel.text ?? "", companyName: companyNameLabel.text ?? "", catchPhrase: companyCatchPhraseLabel.text ?? "", bs: companyBsLabel.text ?? "")
    
    dismiss(animated: true)
    }
    
    func shere() {
        shareOnWhatsApp()
    }
}

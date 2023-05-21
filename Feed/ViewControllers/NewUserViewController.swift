//
//  NewUserViewController.swift
//  Feed
//
//  Created by ברק בן חור on 20/05/2023.
//

import UIKit

class NewUserViewController: UIViewController {
    @IBOutlet var TextFields: [UITextField]!
    
    var viewModel: UsersViewModel!
    
    var numOfItems = 0
    
    @IBAction func back(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func done(_ sender: UIButton) {
        let name = TextFields[0].text ?? ""
        let username = TextFields[1].text ?? ""
        let email = TextFields[2].text ?? ""
        let phone = TextFields[3].text ?? ""
        let website = TextFields[4].text ?? ""
        let street = TextFields[5].text ?? ""
        let suite = TextFields[6].text ?? ""
        let city = TextFields[7].text ?? ""
        let zipcode = TextFields[8].text ?? ""
        let locationComp = (TextFields[9].text ?? "").components(separatedBy: ",")
        var lat = ""
        var lng = ""
        if locationComp.count == 2 {
            lat = locationComp[0]
            lng = locationComp[1]
        }
        let companyName = TextFields[10].text ?? ""
        let catchPhrase = TextFields[11].text ?? ""
        let bs = TextFields[12].text ?? ""
        
        viewModel.addUser(numOfItems: numOfItems, name: name, username: username, email: email, street: street, suite: suite, city: city, zipcode: zipcode, lat: lat, lng: lng, phone: phone, website: website, companyName: companyName, catchPhrase: catchPhrase, bs: bs)
        
        dismiss(animated: true)
    }
}

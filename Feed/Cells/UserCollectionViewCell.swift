//
//  UserCollectionViewCell.swift
//  Feed
//
//  Created by ברק בן חור on 19/05/2023.
//

import UIKit

class UserCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var back: UIView!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var website: UILabel!
    @IBOutlet weak var street: UILabel!
    @IBOutlet weak var suite: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var zipCode: UILabel!
    @IBOutlet weak var geo: UILabel!
    
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var companyCatchPhrase: UILabel!
    @IBOutlet weak var companyBs: UILabel!
    
    func set(user: User) {
        self.name.text = user.name
        self.userName.text = user.username
        self.email.text = user.email
        self.phone.text = user.phone
        self.website.text = user.website
        self.street.text = user.address?.street
        self.suite.text = user.address?.suite
        self.city.text = user.address?.city
        self.zipCode.text = user.address?.zipcode
        self.geo.text = "\(user.address?.geo?.lat ?? "0"), \(user.address?.geo?.lng ?? "0")"
        
        self.companyName.text = user.company?.name
        self.companyCatchPhrase.text = user.company?.catchPhrase
        self.companyBs.text = user.company?.bs
    }
}

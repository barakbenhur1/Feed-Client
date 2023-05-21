//
//  SearchViewModel.swift
//  Feed
//
//  Created by ברק בן חור on 19/05/2023.
//

import UIKit

class UsersViewModel: ViewModel {
    override func callFuncToGetData() {
        Task {
            let result = await apiService.getUsers()
            switch result {
            case .success(let data):
                handeleData(data: data)
            case .failure(let error):
                hendeleError(error: error)
            }
        }
    }
    
    func removeUser(id: String) {
        Task {
            await apiService.removeUser(id: id)
        }
    }
    
    func addUser(numOfItems: Int, name: String, username: String, email: String, street: String, suite: String, city: String, zipcode: String, lat: String, lng: String, phone: String, website: String, companyName: String, catchPhrase: String, bs: String) {
        Task {
            await apiService.addUser(name: name, username: username, email: email, street: street, suite: suite, city: city, zipcode: zipcode, lat: lat, lng: lng, phone: phone, website: website, companyName: companyName, catchPhrase: catchPhrase, bs: bs, size: numOfItems + 1)
        }
    }
    
    func updateUser(id: String, name: String, username: String, email: String, street: String, suite: String, city: String, zipcode: String, lat: String, lng: String, phone: String, website: String, companyName: String, catchPhrase: String, bs: String) {
        Task {
            await apiService.updateUser(id: id, name: name, username: username, email: email, street: street, suite: suite, city: city, zipcode: zipcode, lat: lat, lng: lng, phone: phone, website: website, companyName: companyName, catchPhrase: catchPhrase, bs: bs)
        }
    }
}

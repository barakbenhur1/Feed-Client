//
//  ApiService.swift
//  Feed
//
//  Created by ברק בן חור on 18/05/2023.
//

import Foundation
import UIKit

class APIService :  NSObject {
    
    private enum HTTP {
        enum Error: LocalizedError {
            case invalidResponse
            case badStatusCode
            case missingData
            case noAuth
        }
    }
    
    private let baseurl = URL(string: "http://localhost:10000")!
    
    func downloadImageFrom(url: String) async -> UIImage? {
        return await withCheckedContinuation({ c in
            guard let url = URL(string: url) else { return c.resume(returning: nil) }
            let dataTask = URLSession.shared.dataTask(with: url) { (data, _, _) in
                if let data = data {
                    c.resume(returning:  UIImage(data: data))
                }
            }
            
            dataTask.resume()
        })
    }
    
    func getPosts() async -> (Result<[Post], Error>) {
        return await apiToGetData(url: "posts")
    }
    
    func getPhotos() async -> (Result<[Photo], Error>) {
        return await apiToGetData(url: "photos")
    }
    
    func getToDos() async -> (Result<[ToDo], Error>) {
        return await apiToGetData(url: "toDos")
    }
    
    func getUsers() async -> (Result<[User], Error>) {
        return await apiToGetData(url: "users")
    }
    
    func addPost(title: String, body: String, size: Int) async -> (Result<Empty, Error>) {
        return await apiToGetData(url: "addPost?userId=\("999")&id=\(size)&title=\(title)&body=\(body)&geo=\(LocationManger.sheard.location?.coordinate.latitude ?? .zero),\(LocationManger.sheard.location?.coordinate.latitude ?? .zero)")
    }
    
    func addPhoto(title: String, photo: String, size: Int) async -> (Result<Empty, Error>) {
        return await apiToGetData(url: "addPhoto?userId=\("999")&albumId=\("888")&id=\(size)&title=\(title)&url=\(photo)&thumbnailUrl=\(photo))&geo=\(LocationManger.sheard.location?.coordinate.latitude ?? .zero),\(LocationManger.sheard.location?.coordinate.latitude ?? .zero)")
    }
    
    func addToDo(title: String, size: Int) async -> (Result<Empty, Error>) {
        return await apiToGetData(url: "addToDo?userId=\("999")&id=\(size)&title=\(title))&geo=\(LocationManger.sheard.location?.coordinate.latitude ?? .zero),\(LocationManger.sheard.location?.coordinate.latitude ?? .zero)")
    }
    
    func addUser(name: String, username: String, email: String, street: String, suite: String, city: String, zipcode: String, lat: String, lng: String, phone: String, website: String, companyName: String, catchPhrase: String, bs: String, size: Int) async -> (Result<Empty, Error>) {
        return await apiToGetData(url: "addUser?id=\(size + 1)&userId=\("999")&name=\(name)&username=\(username)&email=\(email)&street=\(street)&suite=\(suite)&city=\(city)&zipcode=\(zipcode)&lat=\(lat)&lng=\(lng)&phone=\(phone)&website=\(website)&companyName=\(companyName)&catchPhrase=\(catchPhrase)&bs=\(bs)&geo=\(LocationManger.sheard.location?.coordinate.latitude ?? .zero),\(LocationManger.sheard.location?.coordinate.latitude ?? .zero)")
    }
    
    @discardableResult func removePost(id: String) async -> (Result<Empty, Error>) {
        return await apiToGetData(url: "removePost?id=\(id)")
    }
    
    @discardableResult func removePhoto(id: String) async -> (Result<Empty, Error>) {
        return await apiToGetData(url: "removePhoto?id=\(id)")
    }
    
    @discardableResult func removeToDo(id: String) async -> (Result<Empty, Error>) {
        return await apiToGetData(url: "removeToDo?id=\(id)")
    }
    
    @discardableResult func removeUser(id: String) async -> (Result<Empty, Error>) {
        return await apiToGetData(url: "removeUser?id=\(id)")
    }
    
    @discardableResult func updatePost(id: String, title: String, body: String) async -> (Result<Empty, Error>) {
        return await apiToGetData(url: "updatePost?userId=\("999")&id=\(id)&title=\(title)&body=\(body)&geo=\(LocationManger.sheard.location?.coordinate.latitude ?? .zero),\(LocationManger.sheard.location?.coordinate.latitude ?? .zero)")
    }
    
    @discardableResult func updatePhoto(id: String, title: String, photo: String) async -> (Result<Empty, Error>) {
        return await apiToGetData(url: "updatePhoto?albumId=\("888")&userId=\("999")&id=\(id)&title=\(title)&url=\(photo)&thumbnailUrl=\(photo)&geo=\(LocationManger.sheard.location?.coordinate.latitude ?? .zero),\(LocationManger.sheard.location?.coordinate.latitude ?? .zero)")
    }
    
    @discardableResult func updateToDo(id: String, title: String) async -> (Result<Empty, Error>) {
        return await apiToGetData(url: "updateToDo?userId=\("999")&id=\(id)&title=\(title)&geo=\(LocationManger.sheard.location?.coordinate.latitude ?? .zero),\(LocationManger.sheard.location?.coordinate.latitude ?? .zero)")
    }
    
    @discardableResult func updateUser(id: String, name: String?, username: String?, email: String?, street: String?, suite: String?, city: String?, zipcode: String?, lat: String?, lng: String?, phone: String?, website: String?, companyName: String?, catchPhrase: String?, bs: String?) async -> (Result<Empty, Error>) {
        return await apiToGetData(url: "updateUser?id=\(id)&userId=\("999")&name=\(name ?? "")&username=\(username ?? "")&email=\(email ?? "")&street=\(street ?? "")&suite=\(suite ?? "")&city=\(city ?? "")&zipcode=\(zipcode ?? "")&lat=\(lat ?? "")&lng=\(lng ?? "")&phone=\(phone ?? "")&website=\(website ?? "")&companyName=\(companyName ?? "")&catchPhrase=\(catchPhrase ?? "")&bs=\(bs ?? "")&geo=\(LocationManger.sheard.location?.coordinate.latitude ?? .zero),\(LocationManger.sheard.location?.coordinate.latitude ?? .zero)")
    }
    
    private func apiToGetData<T: Decodable>(url: String) async -> (Result<T, Error>) {
        return await withCheckedContinuation({ c in
            guard let url = URL(string: "\(self.baseurl)/\(url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)") else { return c.resume(returning: .failure(HTTP.Error.missingData)) }
            URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                    
                    guard let data = try? jsonDecoder.decode(T.self, from: data) else { return c.resume(returning: .failure(HTTP.Error.invalidResponse)) }
                    c.resume(returning: .success(data))
                }
            }.resume()
        })
    }
}

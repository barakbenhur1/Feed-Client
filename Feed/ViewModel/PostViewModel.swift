//
//  FirstViewModel.swift
//  Feed
//
//  Created by ברק בן חור on 18/05/2023.
//

import UIKit

class PostViewModel: ViewModel {
    override func callFuncToGetData() {
        Task {
            let result = await apiService.getPosts()
            switch result {
            case .success(let data):
                handeleData(data: data)
            case .failure(let error):
                hendeleError(error: error)
            }
        }
    }
    
    func addPost(numOfItems: Int, title: String, body: String) {
        Task {
            await apiService.addPost(title: title, body: body, size: numOfItems + 1)
        }
    }
    
    func removePost(id: String) {
        Task {
            await apiService.removePost(id: id)
        }
    }
    
    func updatePost(id: String, title: String, body: String) {
        Task {
            await apiService.updatePost(id: id, title: title, body: body)
        }
    }
}

//
//  PhotosViewModel.swift
//  Feed
//
//  Created by ברק בן חור on 19/05/2023.
//

import UIKit

class PhotosViewModel: ViewModel  {
    override func callFuncToGetData() {
        Task {
            let result = await apiService.getPhotos()
            switch result {
            case .success(let data):
                handeleData(data: data)
            case .failure(let error):
                hendeleError(error: error)
            }
        }
    }
    
    func getImageFrom(url: String) async -> UIImage? {
        return await apiService.downloadImageFrom(url: url)
    }
    
    func removePhoto(id: String) {
        Task {
            await apiService.removePhoto(id: id)
        }
    }
    
    func addPhoto(numOfItems: Int, title: String, image: String) {
        Task {
            await apiService.addPhoto(title: title, photo: image, size: numOfItems + 1)
        }
    }
    
    func updatePhoto(id: String, title: String, photo: String) {
        Task {
            await apiService.updatePhoto(id: id, title: title, photo: photo)
        }
    }
}

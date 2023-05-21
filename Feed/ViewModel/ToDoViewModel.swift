//
//  ToDoViewModel.swift
//  Feed
//
//  Created by ברק בן חור on 19/05/2023.
//

import UIKit

class ToDoViewModel: ViewModel  {
    override func callFuncToGetData() {
        Task {
            let result = await apiService.getToDos()
            switch result {
            case .success(let data):
                handeleData(data: data)
            case .failure(let error):
                hendeleError(error: error)
            }
        }
    }
    
    func removeToDo(id: String) {
        Task {
            await apiService.removeToDo(id: id)
        }
    }
    
    func addToDo(numOfItems: Int, title: String) {
        Task {
            await apiService.addToDo(title: title, size: numOfItems + 1)
        }
    }
    
    func updateToDo(id: String, title: String) {
        Task {
            await apiService.updateToDo(id: id, title: title)
        }
    }
}

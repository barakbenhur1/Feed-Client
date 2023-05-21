//
//  ViewModel.swift
//  Feed
//
//  Created by ברק בן חור on 18/05/2023.
//

import UIKit

class ViewModel: NSObject {
    internal var apiService : APIService!
    internal var data : [ModelProtocol]! {
        didSet {
            self.bindViewModelToController()
        }
    }
    
    var bindViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService =  APIService()
    }
    
    internal func callFuncToGetData() {}
    
    internal func filter(geo: String?) -> [ModelProtocol] {
        var filterd = data
        
        if let geo = geo, !geo.isEmpty {
            filterd = filterd?.filter({ item in
                return item.geo == geo
            })
        }
        
        return filterd ?? []
    }
   
    internal func filter(title: String?, id: String?, userId: String?) -> [ModelProtocol] {
        var filterd = data
        
        if let title = title, !title.isEmpty {
            filterd = filterd?.filter({ item in
                if let result = item.title?.lowercased().starts(with: title.lowercased(), by: { c, ce in return c == ce }) {
                    return result
                }
                return true
            })
        }
        
        if let id = id, !id.isEmpty {
            filterd = filterd?.filter({ item in
                return item.id == Int(id)
            })
        }
        
        if let userId = userId, !userId.isEmpty {
            filterd = filterd?.filter({ item in
                return item.userId == Int(userId)
            })
        }
        
        return filterd ?? []
    }
    
    // MARK: Helpers
    
    internal func hendeleError(error: Error) {
        print(error.localizedDescription)
    }
    
    internal func handeleData(data: [ModelProtocol]) {
        self.data = data
    }
}

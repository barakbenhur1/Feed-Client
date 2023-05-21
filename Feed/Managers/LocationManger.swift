//
//  LocationManger.swift
//  Feed
//
//  Created by ברק בן חור on 21/05/2023.
//

import UIKit
import CoreLocation

class LocationManger: NSObject {
    static let sheard = LocationManger()
    
    var location: CLLocation? = .init()
    
    private override init() {}
}

//
//  MapViewController.swift
//  Feed
//
//  Created by ברק בן חור on 21/05/2023.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    var coord: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let region = MKCoordinateRegion(center: coord ?? .init(), latitudinalMeters: 400, longitudinalMeters: 400)
        mapView.setRegion(region, animated: true)
        
        let wayAnnotation = MKPointAnnotation()
        wayAnnotation.coordinate = coord ?? .init()
        mapView.addAnnotation(wayAnnotation)
    }
    
    @IBAction func back(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

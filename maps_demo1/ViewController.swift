//
//  ViewController.swift
//  maps_demo1
//
//  Created by Brian Voong on 3/4/16.
//  Copyright © 2016 letsbuildthatapp. All rights reserved.
//

import UIKit
import GoogleMaps

class VacationDestination: NSObject {
    
    let name: String
    let location: CLLocationCoordinate2D
    let zoom: Float
    
    init(name: String, location: CLLocationCoordinate2D, zoom: Float) {
        self.name = name
        self.location = location
        self.zoom = zoom
    }
    
}

class ViewController: UIViewController {
    
    var mapView: GMSMapView?
    
    var currentDestination: VacationDestination?
    
    let destinations = [VacationDestination(name: "Embarcadero Station", location: CLLocationCoordinate2DMake(37.792871, -122.397055), zoom: 15), VacationDestination(name: "Ferry Building", location: CLLocationCoordinate2DMake(37.795532, -122.393451), zoom: 18)]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GMSServices.provideAPIKey("AIzaSyA0QlNOrMY6JU7wqgBXBamQq1v9wbR11Z0")
        let camera = GMSCameraPosition.cameraWithLatitude(37.621262, longitude: -122.378945, zoom: 12)
        mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        view = mapView
        
        let currentLocation = CLLocationCoordinate2DMake(37.621262, -122.378945)
        let marker = GMSMarker(position: currentLocation)
        marker.title = "SFO Airport"
        marker.map = mapView
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: "next")
    }
    
    func next() {
        
        if currentDestination == nil {
            currentDestination = destinations.first
        } else {
            if let index = destinations.indexOf(currentDestination!) {
                currentDestination = destinations[index + 1]
            }
        }
        
        setMapCamera()
    }
    
    private func setMapCamera() {
        CATransaction.begin()
        CATransaction.setValue(2, forKey: kCATransactionAnimationDuration)
        mapView?.animateToCameraPosition(GMSCameraPosition.cameraWithTarget(currentDestination!.location, zoom: currentDestination!.zoom))
        CATransaction.commit()
        
        let marker = GMSMarker(position: currentDestination!.location)
        marker.title = currentDestination?.name
        marker.map = mapView
    }

}


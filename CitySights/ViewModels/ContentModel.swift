//
//  ContentModel.swift
//  CitySights
//
//  Created by Bo-Kai Wang on 2021-12-19.
//

import Foundation
import CoreLocation

class ContentModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    
    override init() {
        // init method of NSObject
        super.init()
        // Set ContentModel as the delegate of the location manager
        locationManager.delegate = self
        // Request permission from the user
        locationManager.requestWhenInUseAuthorization()
        
        
    }
    // MARK: - Location Manager Delegate Methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse{
            // We have permission
            // TODO: Start geolocating the user after we get permission
            locationManager.startUpdatingLocation()
            
        }
        else if locationManager.authorizationStatus == .denied {
            // We don't have permission
        }
    }
    // This method is being continuously fired
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Give us the location of the user
        print(locations.first ?? "no location")
        // Stop requesting the location after we get it once
        locationManager.stopUpdatingLocation()
        // TODO: If we have the coordinates of the user, send into Yelp API
    }
}

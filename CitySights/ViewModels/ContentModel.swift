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
    @Published var authorizationState = CLAuthorizationStatus.notDetermined
    @Published var restaurants = [Business]()
    @Published var sights = [Business]()
    
    override init() {
        // init method of NSObject
        super.init()
        // Set ContentModel as the delegate of the location manager
        locationManager.delegate = self
    }
    
    func requestGeolocationPermission() {
        // Request permission from the user
        locationManager.requestWhenInUseAuthorization()
    }
    
    // MARK: - Location Manager Delegate Methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationState = locationManager.authorizationStatus
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
        let userLocation = locations.first
        if userLocation != nil {
            // We have a location
            // Stop requesting the location after we get it once
            locationManager.stopUpdatingLocation()
            // If we have the coordinates of the user, send into Yelp API
            getBusinesses(category: Constants.sightskey, location: userLocation!)
            getBusinesses(category: Constants.restaurantsKey, location: userLocation!)
            
        }
    }
    
    // MARK: - Yelp API methods
    func getBusinesses(category:String, location:CLLocation) {
        // Create URL object
//        let urlString = "https://api.yelp.com/v3/businesses/search?latitude=\(location.coordinate.latitude)&longitude=\(location.coordinate.longitude)&categories=\(category)&limit=6"
//        let url = URL(string: urlString)
        
        var urlComponents = URLComponents(string: Constants.apiUrl)
        urlComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: category),
            URLQueryItem(name: "limit", value: "6")
        ]
        
        let url = urlComponents?.url
        if let url = url {
            // Create URLRequest object
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.addValue("\(Keys.yourApiKey)", forHTTPHeaderField: "Authorization")
            // Get URLSession
            let session = URLSession.shared
            
            // Create dataTask
            let dataTask = session.dataTask(with: request) { data, response, error in
                // Check that there isn't an error
                if error == nil {
                    // Parse json
                    do {
                        let parsedData = try JSONDecoder().decode(BusinessSearch.self, from: data!)
                        // Sort businesses
                        var businesses = parsedData.businesses
                        businesses.sort { (b1, b2) -> Bool in
                            return b1.distance ?? 0 < b2.distance ?? 0
                        }
                        
                        // Call the getImage method of the businesses
                        for b in businesses {
                            b.getImageData()
                        }
                        
                        // Assign results to the appropriate property
                        DispatchQueue.main.async {
                            switch category {
                            case Constants.sightskey:
                                self.sights = businesses
                            case Constants.restaurantsKey:
                                self.restaurants = businesses
                            default:
                                break
                            }
                        }
                    } catch {
                        print(error)
                    }
                }
            }
            // Kick off the dataTask
            dataTask.resume()
        }
        
    }
}

//
//  LocationService.swift
//  Orballo
//
//  Created by Castro, Brais on 1/12/21.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static var shared: LocationManager = LocationManager()
    
    var locationManager: CLLocationManager?
    var lastLocation: CLLocation?

    override init() {
        super.init()

        self.locationManager = CLLocationManager()
        guard let locationManager = self.locationManager else {
            return
        }
        
        if locationManager.authorizationStatus == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 200
        locationManager.delegate = self
    }
    
    func startUpdatingLocation() {
        self.locationManager?.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        self.locationManager?.stopUpdatingLocation()
    }
    
    // CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let location = locations.last else {
            return
        }
        
        self.lastLocation = location
        updateLocation(currentLocation: location)
    }
    
    private func locationManager(_ manager: CLLocationManager, didFailWithError error: NSError) {
        
        updateLocationDidFailWithError(error: error)
    }
    
    // Private function
    private func updateLocation(currentLocation: CLLocation){
        
        UserDefaults.standard.set(currentLocation.coordinate.latitude, forKey: "Latitude")
        UserDefaults.standard.set(currentLocation.coordinate.longitude, forKey: "Longitude")
        stopUpdatingLocation()
    }
    
    private func updateLocationDidFailWithError(error: NSError) {
        
        print(error)
    }
}

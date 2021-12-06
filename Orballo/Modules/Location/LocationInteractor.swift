//
//  LocationInteractor.swift
//  Orballo
//
//  Created by Castro, Brais on 29/11/21.
//

import Foundation
import CoreLocation
import UIKit
import CoreData

protocol LocationInteractorProtocol {
    func getLocationInformation(latitude: Double, longitude: Double)
    func completeWithLocationKey(placeViewModel: Location.PlaceViewModel)
}

protocol LocationInteractorCallbackProtocol {
    func askForConfirmationToAddLocation(placeViewModel: Location.PlaceViewModel)
}

class LocationInteractor {

    var presenter: LocationInteractorCallbackProtocol!
    
    var context: NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
}

extension LocationInteractor: LocationInteractorProtocol {
    
    func getLocationInformation(latitude: Double, longitude: Double) {
        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: latitude, longitude: longitude)) { p, e in
            if let error = e {
                // TODO: Throw error to user
                print(error)
            }
            
            if let placemark = p {
                let place = Location.PlaceViewModel(country: placemark[0].country ?? "Unknown",
                                                      state: placemark[0].administrativeArea ?? "Unknown",
                                                      city: placemark[0].locality ?? "Unknown",
                                                      zipcode: placemark[0].postalCode ?? "Unknown",
                                                      latitude: latitude,
                                                      longitude: longitude)
                self.presenter.askForConfirmationToAddLocation(placeViewModel: place)
            }
        }
    }
    
    func completeWithLocationKey(placeViewModel: Location.PlaceViewModel) {
        do {
            let fetchRequest = LocationEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "city == %@", placeViewModel.city)
            let object = try context.fetch(fetchRequest)
            if (object.count > 0) {
                // TODO: Notify user location already saved (??)
            } else {
                AccuweatherService.shared.getLocationKey(latitude: placeViewModel.latitude, longitude: placeViewModel.longitude) { key in
                    self.saveLocation(placeViewModel: placeViewModel, locationKey: key)
                } failure: { error in
                    print(error)
                }
            }
        } catch {
            print(error)
        }
    }
    
    func saveLocation(placeViewModel: Location.PlaceViewModel, locationKey: String) {
        do {
            let location = LocationEntity(context: self.context)
            location.country = placeViewModel.country
            location.state = placeViewModel.state
            location.city = placeViewModel.city
            location.zipcode = placeViewModel.zipcode
            location.latitude = placeViewModel.latitude
            location.longitude = placeViewModel.longitude
            location.locationKey = locationKey
            location.added = Date()
            try self.context.save()
        } catch {
            print(error)
        }
    }
    
}

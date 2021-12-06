//
//  HomeInteractor.swift
//  Orballo
//
//  Created by Castro, Brais on 28/11/21.
//

import Foundation
import CoreLocation
import UIKit
import CoreData

protocol HomeInteractorProtocol {
    func deleteLocation(locationViewModel: Home.LocationViewModel)
    func createLocationList()
}

protocol HomeInteractorCallbackProtocol {
    func showLocationList(locations: [Home.LocationViewModel])
}

class HomeInteractor {

    var presenter: HomeInteractorCallbackProtocol!
    
    var context: NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
}

extension HomeInteractor: HomeInteractorProtocol {
    
    func deleteLocation(locationViewModel: Home.LocationViewModel) {
        do {
            let fetchRequest = LocationEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "city == %@", locationViewModel.name)
            let objectsToDelete = try context.fetch(fetchRequest)
            objectsToDelete.forEach() { object in
                context.delete(object)
            }
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func createLocationList() {
        let lat = UserDefaults.standard.double(forKey: "Latitude")
        let lon = UserDefaults.standard.double(forKey: "Longitude")
        self.getCurrentGeoLocation(latitude: lat, longitude: lon)
    }
    
    func getCurrentGeoLocation(latitude: Double, longitude: Double) {
        
        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: latitude, longitude: longitude)) { p, e in
            if let error = e {
                print(error)
            }
            
            if let placemark = p {
                let city = placemark[0].locality ?? "Unknown"
                self.createLocationList(city: city)
            } else {
                self.createLocationList(city: nil)
            }
        }
    }
    
    func createLocationList(city: String?) {
        var locations: [Home.LocationViewModel] = []
        if let c = city {
            locations.append(Home.LocationViewModel(name: c,
                                                      isCurrentLocation: true,
                                                      weatherDescription: "",
                                                      temperature: "",
                                                      locationKey: "",
                                                      added: Date(timeIntervalSince1970: 0)))
        }
        
        self.completeListWithSavedLocations(locations: locations)
    }
    
    func completeListWithSavedLocations(locations: [Home.LocationViewModel]) {
        do {
            var locationList = locations
            let savedLocations = try context.fetch(LocationEntity.fetchRequest())
            savedLocations.forEach() { location in
                locationList.append(Home.LocationViewModel(name: location.city ?? "Unknown",
                                                             isCurrentLocation: false,
                                                             weatherDescription: "",
                                                             temperature: "",
                                                             locationKey: location.locationKey ?? "",
                                                             added: location.added!))
            }
            self.getWeatherFromLocations(locations: locationList)
        } catch {
            print(error)
        }
    }
    
    func getWeatherFromLocations(locations: [Home.LocationViewModel]) {
        var locationList: [Home.LocationViewModel] = []
        locations.forEach() { location in
            AccuweatherService.shared.getConditions(location: location.locationKey) { currentConditions in
                let l = Home.LocationViewModel(name: location.name,
                                                 isCurrentLocation: location.isCurrentLocation,
                                                 weatherDescription: currentConditions.WeatherText,
                                                 temperature: "\(currentConditions.Temperature.Metric.Value)º",
                                                 locationKey: location.locationKey,
                                                 added: location.added)
                locationList.append(l)
                self.fillAndReturnList(returnList: locationList, listCapacity: locations.count)
            } failure: { error in
                print(error)
                locationList.append(Home.LocationViewModel(name: location.name,
                                                             isCurrentLocation: location.isCurrentLocation,
                                                             weatherDescription: "",
                                                             temperature: "",
                                                             locationKey: location.locationKey,
                                                             added: location.added))
                self.fillAndReturnList(returnList: locationList, listCapacity: locations.count)
            }
        }
    }
    
    func fillAndReturnList(returnList: [Home.LocationViewModel], listCapacity: Int) {
        if returnList.count == listCapacity {
            self.presenter.showLocationList(locations: returnList.sorted{$0.added < $1.added})
        }
    }
    
}

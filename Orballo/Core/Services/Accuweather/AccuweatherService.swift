//
//  AccuweatherService.swift
//  Orballo
//
//  Created by Castro, Brais on 5/12/21.
//

import Foundation
import Alamofire

class AccuweatherService {
    
    static let shared = AccuweatherService()
    
    private enum AccuweatherServiceAPI {
        
        case geoposition(Double, Double)
        case conditions(String)
        
        func url() -> URL? {
            
            let uri = "http://dataservice.accuweather.com"
            let language = "es-es"
            var apikey = ""
            if let path = Bundle.main.path(forResource: "Services-Info", ofType: "plist"),
                let dictionary = NSDictionary(contentsOfFile: path) {
                apikey = dictionary["accuweather-apikey"] as! String
            }
            
            switch self {
            case .geoposition(let latitude, let longitude) :
                return URL(string: "\(uri)/locations/v1/cities/geoposition/search?apikey=\(apikey)&q=\(latitude),\(longitude)&language=\(language)")
            case .conditions(let location):
                return URL(string: "\(uri)/currentconditions/v1/\(location)?apikey=\(apikey)&language=\(language)")
            }
        
        }
    }
        
    func getLocationKey(latitude: Double, longitude: Double, success: @escaping (_ locationKey: String) -> Void, failure: @escaping (_ error: Error?) -> Void) {
        
        guard let url = AccuweatherServiceAPI.geoposition(latitude, longitude).url() else {
            failure(nil)
            return
        }
        
        AF.request(url).responseDecodable(of: Geoposition.self) { response in
            if let key = response.value?.Key {
                success(key)
                return
            }
            
            failure(response.error)
        }
        
    }
    
    func getConditions(location: String, success: @escaping (_ currentConditions: CurrentConditions) -> Void, failure: @escaping (_ error: Error?) -> Void) {
        
        guard let url = AccuweatherServiceAPI.conditions(location).url() else {
            failure(nil)
            return
        }
        
        AF.request(url).responseDecodable(of: [CurrentConditions].self) { response in
            if let conditions = response.value {
                success(conditions.first!)
                return
            }
            
            failure(response.error)
        }
        
    }

}

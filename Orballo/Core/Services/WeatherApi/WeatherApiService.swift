//
//  WeatherApiService.swift
//  Orballo
//
//  Created by Castro, Brais on 9/12/21.
//

import Foundation
import Alamofire

class WeatherApiService {
    
    /* WeatherApi: https://www.weatherapi.com/docs/ */
    
    static let shared = WeatherApiService()
    
    private enum WeatherApiServiceAPI {
        
        case current(Double, Double)
        
        func url() -> URL? {
            
            let uri = "https://api.weatherapi.com/v1"
            var apikey = ""
            if let path = Bundle.main.path(forResource: "Services-Info", ofType: "plist"),
                let dictionary = NSDictionary(contentsOfFile: path) {
                apikey = dictionary["weatherapi-apikey"] as! String
            }
            
            switch self {
            case .current(let latitude, let longitude) :
                return URL(string: "\(uri)/current.json?key=\(apikey)&q=\(latitude),\(longitude)&aqi=no")
            }
        
        }
    }
    
    func current(latitude: Double, longitude: Double, success: @escaping (_ weather: Current) -> Void, failure: @escaping (_ error: Error?) -> Void) {
        
        guard let url = WeatherApiServiceAPI.current(latitude, longitude).url() else {
            failure(nil)
            return
        }
        
        AF.request(url).responseDecodable(of: Weather.self) { response in
            if let current = response.value?.current {
                success(current)
                return
            }
            
            failure(response.error)
        }
        
    }
    
}

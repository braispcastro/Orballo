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
        case astronomy(Double, Double)
        
        func url() -> URL? {
            
            let uri = "https://api.weatherapi.com/v1"
            var apikey = ""
            if let path = Bundle.main.path(forResource: "Services-Info", ofType: "plist"),
                let dictionary = NSDictionary(contentsOfFile: path) {
                apikey = dictionary["weatherapi-apikey"] as! String
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.string(from: Date())
            
            switch self {
            case .current(let latitude, let longitude):
                return URL(string: "\(uri)/current.json?key=\(apikey)&q=\(latitude),\(longitude)&aqi=no")
            case .astronomy(let latitude, let longitude):
                return URL(string: "\(uri)/astronomy.json?key=\(apikey)&q=\(latitude),\(longitude)&dt=\(date)")
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
    
    func astronomy(latitude: Double, longitude: Double, success: @escaping (_ astro: Astro) -> Void, failure: @escaping (_ error: Error?) -> Void) {
        
        guard let url = WeatherApiServiceAPI.astronomy(latitude, longitude).url() else {
            failure(nil)
            return
        }
        
        AF.request(url).responseDecodable(of: SkyTime.self) { response in
            if let astro = response.value?.astronomy.astro {
                success(astro)
                return
            }
            
            failure(response.error)
        }
        
    }
    
}

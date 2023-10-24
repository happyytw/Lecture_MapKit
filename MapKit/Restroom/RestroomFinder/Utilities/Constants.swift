//
//  Constants.swift
//  RestroomFinder
//
//  Created by Taewon Yoon on 10/23/23.
//

import Foundation

struct Constants {
    struct Urls {
        static func restroomsByLocation(latitude: Double, longitude: Double) -> URL {
            return URL(string: "https://www.refugerestrooms.org/api/v1/restrooms/by_location?lat=\(latitude)&lng=\(longitude)")!
        }
    }
}

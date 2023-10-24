//
//  MapUtilities.swift
//  Hello-Maps
//
//  Created by Taewon Yoon on 10/12/23.
//

import Foundation
import MapKit

func makeCall(phone: String) {
    if let url = URL(string: "tel://\(phone)") {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url) // 만약에 가능한 전화번호면 전화를 연다.
        } else {
            print("Device can't make phone calls")
        }
    }
}

func calculateDirections(from: MKMapItem, to: MKMapItem) async -> MKRoute? {
    
    let directionsRequest = MKDirections.Request()
    directionsRequest.transportType = .automobile // walking, any, automobile, transit 이 있다.
    directionsRequest.source = from // 경로를 찾기 위한 출발 지점 지정
    directionsRequest.destination = to // 경로를 찾기 위한 도착 지점 지정
    
    let directions = MKDirections(request: directionsRequest) // 위에서 설정한 값을 넣는다.
    let response = try? await directions.calculate() // 설정된 장소를 계산한다.
    return response?.routes.first
}

func calculateDistance(from: CLLocation, to: CLLocation) -> Measurement<UnitLength> { // Measurment API를 사용해서 각각 나라에 규격에 맞게 단위를 반환한다.
    let distanceInMeters = from.distance(from: to)
    return Measurement(value: distanceInMeters, unit: .meters)
}

func performSearch(searchTerm: String, visibleRegion: MKCoordinateRegion?) async throws -> [MKMapItem] {
    
    let request = MKLocalSearch.Request()
    request.naturalLanguageQuery = searchTerm
    request.resultTypes = .pointOfInterest
    
    guard let region = visibleRegion else { return [] }
    request.region = region
    
    let search = MKLocalSearch(request: request)
    let response = try await search.start()
    
    return response.mapItems
}

//
//  LocationManager.swift
//  Hello-Maps
//
//  Created by Taewon Yoon on 10/7/23.
//

import Foundation
import MapKit
import Observation

@Observable // 이 코드를 사용하면 클래스를 Observable로 만들겠다는 메크로인것 같다?
class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager() // 싱글톤이다.
    var manager: CLLocationManager = CLLocationManager() // 이게 진짜 LoactionManager이고 위치 권한에 대한 것들을 담당한다.
    var region: MKCoordinateRegion = MKCoordinateRegion() // @Observation으로 메크로를 설정해놔서 @Published를 설정하지 않아도 이미 Published 되어 있다.
    
    override init() {
        super.init()
        self.manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.last.map {
            // span = 확대 정도
            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))
        }
    }
    
    // ocationManagerDidChangeAuthorization의 좋은점은 LocationManager가 실행될때마다 자동으로 실행된다.
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization() // 앱을 사용중일때 물어본다.
        case .authorizedAlways, .authorizedWhenInUse: // 항상 허용, 앱을 실행중일때만 허용
            manager.requestLocation() // 위치를 한번 요청한다.
        case .denied:
            print("denied")
        case .restricted:
            print("restricted")
        default:
            break
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

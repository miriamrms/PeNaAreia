//
//  DistanceViewModel.swift
//  PeNaAreia
//
//  Created by Miriam Mendes on 10/09/24.
//

import Foundation
import CoreLocation
import MapKit

class DistanceViewModel: NSObject, ObservableObject, CLLocationManagerDelegate{
    @Published var location: CLLocation?
    var locationManager: CLLocationManager
    
    override init() {
        self.locationManager = .init()
        super.init()
        locationManager.delegate = self
    }
    func checkIfLocationServiceIsEnable(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager()
            locationManager.delegate = self
        }
        else{
            print("Show Alert")
        }
    }
    
    private func checkLocationAuthorization(){
        switch locationManager.authorizationStatus{
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your Location is restricted")
        case .denied:
            print("Your Location is denied")
        case .authorizedAlways, .authorizedWhenInUse:
            guard let location = locationManager.location else{return}
            self.location = location
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    
}

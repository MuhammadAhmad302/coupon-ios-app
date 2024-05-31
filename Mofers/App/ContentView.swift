//
//  ContentView.swift
//  Mofers
//
//  Created by Rashdan Natiq on 2023-03-01.
//

import SwiftUI
import Firebase
import CoreLocation

struct ContentView: View {


    var body: some View {
        ZStack {
            CustomTabView()
            LandingPageScreen()
        }
    }
}




class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    let locationManager = CLLocationManager()

    override init() {
        super.init()
        self.locationManager.delegate = self
    }

    func requestLocation() {
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // handle updated locations
        print(locations)
        let userLocation = locations[0] as CLLocation
        print(userLocation.coordinate.latitude)
        print(userLocation.coordinate.longitude)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // handle errors
        print(error.localizedDescription)
    }
}





//class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
//    let locationManager = CLLocationManager()
//    var currentLocation: CLLocation?
//
//    override init() {
//        super.init()
//        self.locationManager.delegate = self
//        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        self.locationManager.requestWhenInUseAuthorization()
//    }
//
//    func requestLocation() {
//        self.locationManager.requestLocation()
//    }
//
//    func startUpdatingLocation() {
//        self.locationManager.startUpdatingLocation()
//    }
//
//    func stopUpdatingLocation() {
//        self.locationManager.stopUpdatingLocation()
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.last {
//            self.currentLocation = location
//            print(location.coordinate.latitude)
//            print(location.coordinate.longitude)
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print(error.localizedDescription)
//    }
//}


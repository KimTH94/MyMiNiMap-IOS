//
//  MiniMapViewController.swift
//  MyMiniMap
//
//  Created by TaeHwan Kim on 02/08/2019.
//  Copyright © 2019 TaeHwan Kim. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MiniMapViewController: UIViewController, CLLocationManagerDelegate {
    
    var SEQ_User:String = ""
    
    var name: String = ""
    var latitude: String = ""
    var longitude: String = ""
    var address: String = ""
    var id: String = ""
    
    var locationManager = CLLocationManager()
    
    lazy var mapView = GMSMapView()
    
    override func viewDidLoad() {
        
        let googleAPIKey: String = "AIzaSyDSMQLcRfJQUkkFrYRsCxtcM7cVoac6TIc"
        let Latitude: Double = 37.561137
        let longitude: Double = 127.001717
        GMSServices.provideAPIKey(googleAPIKey)
        let camera = GMSCameraPosition.camera(withLatitude: Latitude, longitude: longitude, zoom: 17.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.settings.myLocationButton = true
        
        view = mapView

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        print("SEQ_User : \(UserDefaults.standard.integer(forKey: "SEQ_User"))")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.last
        let center = CLLocationCoordinate2D(latitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude)
        let camera = GMSCameraPosition.camera(withLatitude: userLocation!.coordinate.latitude,
                                              longitude: userLocation!.coordinate.longitude, zoom: 13.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        self.view = mapView
        print("---> current location : latitude : \(userLocation!.coordinate.latitude) , longitude : \(userLocation!.coordinate.longitude)")
        locationManager.stopUpdatingLocation()
    }
    
    // Present the Autocomplete view controller when the button is pressed.
    @IBAction func autocompleteClicked(_ sender: UIBarButtonItem) {
        print("adfsd")
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        // Specify the place data types to return.
        //        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
        //            UInt(GMSPlaceField.placeID.rawValue))!
        let fields: GMSPlaceField = GMSPlaceField(rawValue:UInt(GMSPlaceField.name.rawValue) |
            UInt(GMSPlaceField.placeID.rawValue) |
            UInt(GMSPlaceField.coordinate.rawValue) |
            GMSPlaceField.addressComponents.rawValue |
            GMSPlaceField.formattedAddress.rawValue)!
        autocompleteController.placeFields = fields
        //        autocompleteController.placeFields = fields
        
        // Specify a filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .noFilter
        autocompleteController.autocompleteFilter = filter
        
        // Display the autocomplete view controller.
        present(autocompleteController, animated: true, completion: nil)
    }
}

extension MiniMapViewController: GMSAutocompleteViewControllerDelegate {
    // Handle the user's selection.
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        name = place.name ?? ""
        latitude = String(place.coordinate.latitude) ?? ""
        longitude = String(place.coordinate.longitude) ?? ""
        address = place.formattedAddress ?? ""
        id = place.placeID ?? ""
        
        print("Place name: \(place.name)")
        print("Place ID: \(place.placeID)")
        print("Place attributions: \(place.attributions)")
        print("Place coordinate latitude: \(place.coordinate.latitude)")
        print("Place coordinate longitude: \(place.coordinate.longitude)")
        
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 17.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        //        marker.title = place.name
        //        marker.snippet = place.formattedAddress
        marker.map = mapView
        mapView.delegate = self
        
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}

extension MiniMapViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print("클릭~")
        print("marker latitude: \(marker.position.latitude)")
        print("marker longitude: \(marker.position.longitude)")
        performSegue(withIdentifier: "showSaveView", sender: self)
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSaveView"{
            let passingData = segue.destination as! SaveRestaurantViewController
            passingData.name = name
            passingData.address = address
            passingData.latitude = latitude
            passingData.longitude = longitude
            passingData.id = id
        }
    }
}


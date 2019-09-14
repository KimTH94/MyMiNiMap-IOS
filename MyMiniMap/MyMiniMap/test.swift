//
//  test.swift
//  MyMiniMap
//
//  Created by TaeHwan Kim on 02/08/2019.
//  Copyright © 2019 TaeHwan Kim. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps

class test: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude:place.coordinate.longitude , zoom: 15.0)
        self.googleMapView.camera = camera
        self.dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("---> Error autocomplete \(error.localizedDescription)")
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    

    let GoogleAPI = "AIzaSyDSMQLcRfJQUkkFrYRsCxtcM7cVoac6TIc"
    
    @IBOutlet var googleMapView: GMSMapView!
    
    var locationManager  = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self as! CLLocationManagerDelegate
        locationManager.requestWhenInUseAuthorization()
        initGoogleMaps()
    }
    
    func initGoogleMaps(){
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        googleMapView = mapView
        self.googleMapView.delegate = self
        self.googleMapView.isMyLocationEnabled = true
        self.googleMapView.settings.myLocationButton = true
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    @IBAction func searchWithAddress(_ sender: Any) {
//        let searchController = UISearchController(searchResultsController: nil)
//        searchController.searchBar.delegate = self
//        self.present(searchController, animated: true, completion: nil)
//        searchController.searchBar.setValue("취소", forKey: "cancelButtonText")
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        
        self.locationManager.startUpdatingLocation()
        self.present(autoCompleteController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithEorror error: Error){
        print("---> Error while get location \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let location = locations.last
        
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)
        
        self.googleMapView.animate(to: camera)
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        self.googleMapView.isMyLocationEnabled = true
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        self.googleMapView.isMyLocationEnabled = true
        if (gesture) {
            mapView.selectedMarker = nil
        }
    }
}

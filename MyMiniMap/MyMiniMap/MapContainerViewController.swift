//
//  MapContainerViewController.swift
//  MyMiniMap
//
//  Created by TaeHwan Kim on 19/08/2019.
//  Copyright © 2019 TaeHwan Kim. All rights reserved.
//

import UIKit
import GoogleMaps

struct RestaurantResponse: Codable {
    var restaurant: [restaurant]
}

struct restaurant: Codable {
    var Name: String
    var Address: String
    var Id: String
    var Lat: Double
    var Lng: Double
}

class MapContainerViewController: UIViewController, GMSMapViewDelegate{

    var SEQ_Owner:Int!
    
    @IBOutlet weak var alertView: UIView!
    
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbAddress: UILabel!
    @IBOutlet weak var lbCount: UILabel!
    
    var restaurantList: [restaurant] = []
    var state: Int = 0
    var stateId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let googleAPIKey: String = "AIzaSyDSMQLcRfJQUkkFrYRsCxtcM7cVoac6TIc"
        let Latitude: Double = 37.561137
        let longitude: Double = 127.001717
        GMSServices.provideAPIKey(googleAPIKey)
        let camera = GMSCameraPosition.camera(withLatitude: Latitude, longitude: longitude, zoom: 17.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.settings.myLocationButton = true 
        view = mapView
        self.view.addSubview(alertView)
        alertView.isHidden = true
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://112.149.7.38:8090/Final_Minimap/Ios/MapContainer.jsp")! as URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        print("1. MapContainer SEQ_User :\(UserDefaults.standard.integer(forKey: "SEQ_User")), SEQ_Owner : \(SEQ_Owner)")
        
        if (SEQ_Owner == nil) {
            SEQ_Owner = UserDefaults.standard.integer(forKey: "SEQ_User")
        }
        
        print("2. MapContainer SEQ_User :\(UserDefaults.standard.integer(forKey: "SEQ_User")), SEQ_Owner : \(SEQ_Owner)")
        
        let postString = "SEQ_Owner=\(SEQ_Owner!)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil {
                print("error=\(error)")
                return
            }
            
            
            guard let resultData = data else { return }
            self.restaurantList = self.parse(data: resultData) ?? []
            
            print("------> 카운트 \(self.restaurantList.count)")
            for user in self.restaurantList {
                print("Name : \(user.Name)")
                print("Adrress : \(user.Address)")
                print("Id : \(user.Id)")
                print("Lat : \(user.Lat)")
                print("Lng : \(user.Lng)")
                print("---------------")
            }
            
            print("핀 생성")
            print("userListCount \(self.restaurantList.count)")
            
            DispatchQueue.main.sync {
                for data in self.restaurantList {
                    let location = CLLocationCoordinate2D(latitude: data.Lat, longitude: data.Lng)
                    print("location: \(location)")
                    let marker = GMSMarker()
                    marker.position = location
                    marker.snippet = data.Name
                    marker.title = data.Address
                    marker.accessibilityHint = data.Id
                    marker.map = mapView
                }
            }

        }
        task.resume()
        mapView.delegate = self as GMSMapViewDelegate
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        mapView.delegate = self as GMSMapViewDelegate
        
        if state == 0 && stateId == marker.accessibilityHint{
            stateId = marker.accessibilityHint!
            lbName.text = marker.snippet!
            lbAddress.text = marker.title!
            alertView.isHidden = false
            state = 1
        }else if state == 0 && stateId != marker.accessibilityHint{
            stateId = marker.accessibilityHint!
            lbName.text = marker.snippet!
            lbAddress.text = marker.title!
            alertView.isHidden = false
            state = 1
        }else if state == 1 && stateId == marker.accessibilityHint{
            alertView.isHidden = true
            state = 0
        }else if state == 1 && stateId != marker.accessibilityHint{
            stateId = marker.accessibilityHint!
            lbName.text = marker.snippet!
            lbAddress.text = marker.title!
        }
        return true
    }
    
    func parse(data: Data) -> [restaurant]? {
        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(RestaurantResponse.self, from: data)
            let userList = response.restaurant
            return userList
        } catch let error {
            print("---> error : \(error.localizedDescription)")
            return nil
        }
    }
}

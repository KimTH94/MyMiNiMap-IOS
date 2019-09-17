//
//  MyFeedViewController.swift
//  MyMiniMap
//
//  Created by TaeHwan Kim on 18/08/2019.
//  Copyright © 2019 TaeHwan Kim. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire

struct FeedTopResponse: Codable {
    var result: [FeedTop]
}

struct RestaurantResponse1: Codable {
    var restaurant: [restaurant1]
}

struct FeedTop: Codable {
    var SEQ_User: Int
    var ProfileImage: String
    var countPosts: Int
    var countFollower: Int
    var countFriend: Int
}


struct restaurant1: Codable {
    var Name: String
    var Address: String
    var Count: Int
    var Id: String
    var Lat: Double
    var Lng: Double
}

struct FeedPhotoResponse1: Codable {
    var presult: [FeedPhoto1]
}

struct FeedPhoto1: Codable {
    var SEQ_User: Int
    var SEQ_Post: Int
    var SEQ_Attachment: Int
    var SaveType: Int
    var FoodType: Int
    var Price: Int
    var Id: String
    var Colleague: String
    var FileName: String
    var Count: Int
}

struct Item1 {
    var FileName: String
    var SEQ_Post: Int
    var SEQ_User: Int
}

class MyFeedViewController: UIViewController, GMSMapViewDelegate{
    
    var SEQ_Owner: Int!
    var imgData = Array<Data>()
    
    @IBOutlet var btnMap: UIButton!
    @IBOutlet var btnFeed: UIButton!

    @IBOutlet var MapView1: GMSMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var lbPost: UILabel!
    @IBOutlet weak var lbFollower: UILabel!
    @IBOutlet weak var lbFriend: UILabel!
    
    @IBOutlet weak var btn: UIButton!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var alertViewlbName: UILabel!
    @IBOutlet weak var alertVeiwlbAddress: UILabel!
    @IBOutlet weak var alertViewlbCount: UILabel!
    
    var collectionViewFlowLayout: UICollectionViewFlowLayout!
    var cellIdentifier = "ItemCollectionViewCell"
    
    var FeedPhotoList: [FeedPhoto1] = []
    var items: [Item1] = []
    
    var SEQ_PostStack: Int = 0
    
    var state: Int = 0
    var stateId: String = ""
    
    var userList: [FeedTop] = []
    var restaurantList: [restaurant1] = []

    let picker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        let googleAPIKey: String = "AIzaSyDSMQLcRfJQUkkFrYRsCxtcM7cVoac6TIc"
        let Latitude: Double = 37.561137
        let longitude: Double = 127.001717
        GMSServices.provideAPIKey(googleAPIKey)
        let camera = GMSCameraPosition.camera(withLatitude: Latitude, longitude: longitude, zoom: 17.0)
        MapView1 = GMSMapView.map(withFrame: self.MapView1.frame, camera: camera)
        MapView1.settings.myLocationButton = true
        self.view.addSubview(MapView1)
        self.view.addSubview(collectionView)
        MapView1.addSubview(alertView)
        alertView.isHidden = true
        collectionView.isHidden = true
        
        // Do any additional setup after loading the view.

        
        
        profileImage.addTapGestureRecognizer {
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            let delete = UIAlertAction(title: "삭제", style: .destructive) { action in
                print("현재 사진 삭제")
            }
            
            let modify = UIAlertAction(title: "수정", style: .default) { action in
                self.openLibrary()
            }
            
            let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            
            actionSheet.addAction(delete)
            actionSheet.addAction(modify)
            actionSheet.addAction(cancel)
            
            self.present(actionSheet, animated: true, completion: nil)
        }
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://112.149.7.38:8090/Final_Minimap/Ios/FeedTop.jsp")! as URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        if (SEQ_Owner == nil) {
            SEQ_Owner = UserDefaults.standard.integer(forKey: "SEQ_User")
        }
        let postString = "SEQ_User=\(SEQ_Owner!)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil {
                print("error=\(error)")
                return
            }
            
        guard let resultData = data else { return }
        self.userList = self.parse(data: resultData) ?? []
        self.restaurantList = self.parse1(data: resultData) ?? []
        self.FeedPhotoList = self.parse2(data: resultData) ?? []

        DispatchQueue.main.async {
            for user in self.userList {
                self.lbPost.text = String(user.countPosts)
                self.lbFollower.text = String(user.countFollower)
                self.lbFriend.text = String(user.countFriend)
                self.profileImage!.sd_setImage(with: URL(string: "http://112.149.7.38:8090/Final_Minimap/imageupload/\(user.ProfileImage)"), completed: nil)
            }
                
            for data in self.restaurantList {
                let location = CLLocationCoordinate2D(latitude: data.Lat, longitude: data.Lng)
                let marker = GMSMarker()
                marker.position = location
                marker.snippet = data.Name
                marker.title = data.Address
                marker.accessibilityHint = data.Id
                marker.accessibilityLabel = "\(data.Count)명이 등록하였습니다."
                marker.map = self.MapView1
            }
            
            for user in self.FeedPhotoList {
                if (self.SEQ_PostStack != user.SEQ_Post) {
                    self.items.append(Item1(FileName: user.FileName, SEQ_Post: user.SEQ_Post, SEQ_User: user.SEQ_User))
                    self.SEQ_PostStack = user.SEQ_Post
                }
            }
            
            if self.SEQ_Owner == UserDefaults.standard.integer(forKey: "SEQ_User") {
                self.btn.setTitle("프로필 수정", for: .normal)
                self.btn.layer.borderColor = UIColor.gray.cgColor
                self.btn.layer.cornerRadius = 7
                self.btn.clipsToBounds = true
                self.btn.layer.borderWidth = 0.5
            }else if self.SEQ_Owner != UserDefaults.standard.integer(forKey: "SEQ_User") {
                self.btn.setTitle("팔 로 우", for: .normal)
                self.btn.setTitleColor(.white, for: .normal)
                self.btn.layer.borderColor = UIColor.white.cgColor
                self.btn.layer.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0).cgColor
                self.btn.layer.cornerRadius = 7
                self.btn.clipsToBounds = true
                self.btn.layer.borderWidth = 0.5
            }
            self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2
            self.profileImage.clipsToBounds = true
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
            print("\(self.items)")
            self.setUpCollectionView()
        }
    }
    task.resume()
        
    MapView1.delegate = self as! GMSMapViewDelegate
    
}
    func openLibrary()    {
        picker.sourceType = .photoLibrary
        present(picker, animated: false, completion: nil)
    }

    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        mapView.delegate = self as! GMSMapViewDelegate

        if state == 0 && stateId == marker.accessibilityHint{
            stateId = marker.accessibilityHint!
            alertViewlbName.text = marker.snippet!
            alertVeiwlbAddress.text = marker.title!
            alertViewlbCount.text = marker.accessibilityLabel!
            alertView.isHidden = false
            state = 1
        }else if state == 0 && stateId != marker.accessibilityHint{
            stateId = marker.accessibilityHint!
            alertViewlbName.text = marker.snippet!
            alertVeiwlbAddress.text = marker.title!
            alertViewlbCount.text = marker.accessibilityLabel!
            alertView.isHidden = false
            state = 1
        }else if state == 1 && stateId == marker.accessibilityHint{
            alertView.isHidden = true
            state = 0
        }else if state == 1 && stateId != marker.accessibilityHint{
            stateId = marker.accessibilityHint!
            alertViewlbName.text = marker.snippet!
            alertVeiwlbAddress.text = marker.title!
            alertViewlbCount.text = marker.accessibilityLabel!
        }
        return true
    }
    
    func parse(data: Data) -> [FeedTop]? {
        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(FeedTopResponse.self, from: data)
            let userList = response.result
            return userList
        } catch let error {
            print("---> error : \(error.localizedDescription)")
            return nil
        }
    }
    
    func parse1(data: Data) -> [restaurant1]? {
        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(RestaurantResponse1.self, from: data)
            let userList = response.restaurant
            return userList
        } catch let error {
            print("---> error : \(error.localizedDescription)")
            return nil
        }
    }

    @IBAction func btnMapClicked(_ sender: UIButton) {
        print("지도 버튼 클릭")
        MapView1.isHidden = false
        collectionView.isHidden = true
    }
    @IBAction func btnFeedClicked(_ sender: UIButton) {
        print("피트 버튼 클릭")
        MapView1.isHidden = true
        collectionView.isHidden = false
    }
    
    func parse2(data: Data) -> [FeedPhoto1]? {
        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(FeedPhotoResponse1.self, from: data)
            let FeedPhotoList = response.presult
            return FeedPhotoList
        } catch let error {
            print("---> error : \(error.localizedDescription)")
            return nil
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupCollectionViewItemSize()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let item = sender as! Item1
        if segue.identifier == "abc1" {
            if let vc = segue.destination as? FullFeedViewController {
                vc.imageName = item.FileName
                vc.SEQ_Post = item.SEQ_Post
                vc.SEQ_User = item.SEQ_User
                vc.SEQ_Owner = SEQ_Owner
            }
        }
    }
    
    private func setUpCollectionView(){
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        let nib = UINib(nibName: "ItemCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    private func setupCollectionViewItemSize(){
        if collectionViewFlowLayout == nil {
            let numberOfItemForRow: CGFloat = 3
            let lineSpacing: CGFloat = 5
            let interItemSpacing: CGFloat = 5
            
            let width = (collectionView.frame.width - (numberOfItemForRow - 1) * interItemSpacing) / numberOfItemForRow
            let heigth = width
            
            collectionViewFlowLayout = UICollectionViewFlowLayout()
            
            collectionViewFlowLayout.itemSize = CGSize(width: width, height: heigth)
            collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
            collectionViewFlowLayout.scrollDirection = .vertical
            collectionViewFlowLayout.minimumLineSpacing = lineSpacing
            collectionViewFlowLayout.minimumInteritemSpacing = interItemSpacing
            
            collectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        }
    }
}

extension UIView {
    
    fileprivate struct AssociatedObjectKeys {
        static var tapGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
    }
    
    fileprivate typealias Action = (() -> Void)?
    
    fileprivate var tapGestureRecognizerAction: Action? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer) as? Action
            return tapGestureRecognizerActionInstance
        }
    }
    
    
    public func addTapGestureRecognizer(action: (() -> Void)?) {
        self.isUserInteractionEnabled = true
        self.tapGestureRecognizerAction = action
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
    @objc fileprivate func handleTapGesture(sender: UITapGestureRecognizer) {
        if let action = self.tapGestureRecognizerAction {
            action?()
            print("action")
        } else {
            print("no action")
        }
    }
}

extension MyFeedViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    //Number of View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    //Populate View
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ItemCollectionViewCell
        print("image name : \(items[indexPath.item].FileName)")
        let url = URL(string: "http://112.149.7.38:8090/Final_Minimap/imageupload/" + items[indexPath.item].FileName)
        let data = try? Data(contentsOf: url!)
        cell.imageView.image = UIImage(data: data!)
        return cell
    }
    //Select Item
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("---> item : \(indexPath)")
        let item = items[indexPath.item]
        performSegue(withIdentifier: "abc1", sender: item)
    }
}

extension MyFeedViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImage.image = image
            let parameters = ["SEQ_User": String(UserDefaults.standard.integer(forKey: "SEQ_User"))]
            Alamofire.upload(multipartFormData: { multipartFormData in
                self.imgData.append(image.jpegData(compressionQuality: 0.7)!)
                print("image 출력 : \(self.imgData[0])" )
                multipartFormData.append(self.imgData[0], withName: "fileset",fileName: "a.jpg", mimeType: "image/jpg")
                for (key, value) in parameters {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
            }, to:"http://112.149.7.38:8090/Final_Minimap/ChangeProfile")
            { (result) in
                switch result {
                case .success(let upload, _, _):
                    upload.uploadProgress(closure: { (progress) in
                        print("Upload Progress: \(progress.fractionCompleted)")
                    })
                    upload.responseJSON { response in
                        print(response.result.value)
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
            }
        }
        dismiss(animated: true, completion: nil)
    }
}

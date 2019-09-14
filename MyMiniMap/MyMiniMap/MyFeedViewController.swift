//
//  MyFeedViewController.swift
//  MyMiniMap
//
//  Created by TaeHwan Kim on 18/08/2019.
//  Copyright © 2019 TaeHwan Kim. All rights reserved.
//

import UIKit
import GoogleMaps

struct FeedTopResponse: Codable {
    var result: [FeedTop]
}

struct FeedTop: Codable {
    var SEQ_User: Int
    var ProfileImage: String
    var countPosts: Int
    var countFollower: Int
    var countFriend: Int
}


class MyFeedViewController: UIViewController{
    
    var SEQ_Owner: Int!
    
    @IBOutlet var btnMap: UIButton!
    @IBOutlet var btnFeed: UIButton!
    
    @IBOutlet var MapView: UIView!
    @IBOutlet var FeedView: UIView!
    
    @IBOutlet weak var lbPost: UILabel!
    @IBOutlet weak var lbFollower: UILabel!
    @IBOutlet weak var lbFriend: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    var userList: [FeedTop] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print("MyFeed SEQ_User :\(UserDefaults.standard.integer(forKey: "SEQ_User")), SEQ_Owner : \(UserDefaults.standard.integer(forKey: "SEQ_Owner"))")
        
        MapView.isHidden = false
        FeedView.isHidden = true
        // Do any additional setup after loading the view.
        
        let url = URL(string: "http://112.149.7.38:8090/Final_Minimap/imageupload/default.png")
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        profileImage.image = UIImage(data: data!)
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
        
        profileImage.addTapGestureRecognizer {
            print("image tapped")
        }
        
        //        profileImage.image = UIImage(named: "http://112.149.7.38:8090/Final_Minimap/imageupload/default.png")
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://112.149.7.38:8090/Final_Minimap/Ios/FeedTop.jsp")! as URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        print("1. MyFeed SEQ_User :\(UserDefaults.standard.integer(forKey: "SEQ_User")), SEQ_Owner : \(SEQ_Owner)")
        
        if (SEQ_Owner == nil) {
            SEQ_Owner = UserDefaults.standard.integer(forKey: "SEQ_User")
        }
        
        print("2. MyFeed SEQ_User :\(UserDefaults.standard.integer(forKey: "SEQ_User")), SEQ_Owner : \(SEQ_Owner)")
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
            for user in self.userList {
                print("SEQ_User : \(user.SEQ_User)")
                print("ProfileImage : \(user.ProfileImage)")
                print("Posts : \(user.countPosts)")
                print("Follower : \(user.countFollower)")
                print("Friend : \(user.countFriend)")
                self.lbPost.text = String(user.countPosts)
                self.lbFollower.text = String(user.countFollower)
                self.lbFriend.text = String(user.countFriend)
            }

        }
        task.resume()
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let embeddedVC = segue.destination as? MyFeedViewController where segue.identifier == "go1" {
            embeddedVC.SEQ_Owner = self.SEQ_Owner
        }
    }
    
    @IBAction func btnMapClicked(_ sender: UIButton) {
        print("지도 버튼 클릭")
        MapView.isHidden = false
        FeedView.isHidden = true
    }
    @IBAction func btnFeedClicked(_ sender: UIButton) {
        print("피트 버튼 클릭")
        MapView.isHidden = true
        FeedView.isHidden = false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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

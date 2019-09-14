//
//  FullFeedViewController.swift
//  MyMiniMap
//
//  Created by TaeHwan Kim on 19/08/2019.
//  Copyright © 2019 TaeHwan Kim. All rights reserved.
//

import UIKit
import SDWebImage

struct FeedAllResponse: Codable {
    var result: [String]
    var feed: [FeedInfo]
}

struct FeedInfo: Codable {
    var likeState: Int
    var likeCount: Int
}

class FullFeedViewController: UIViewController {

    @IBOutlet weak var likeImage: UIImageView!
    
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbLikeCount: UILabel!

    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnDetail: UIButton!
    @IBOutlet weak var btnPin: UIButton!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var imageName: String!
    var SEQ_Post: Int!
    var SEQ_User: Int!
    var SEQ_Owner: Int!

    var list:[String] = []
    var feedlist:[FeedInfo] = []

    var PhotoName: [String] = []
    
    var likeState:Int = 0
    var likeCount:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("SEQ_Post : \(SEQ_Post!)")
        print("SEQ_User : \(SEQ_User!)")
        print("SEQ_User : \(SEQ_Owner!)")
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://112.149.7.38:8090/Final_Minimap/Ios/FeedAllPhoto.jsp")! as URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "SEQ_User=\(UserDefaults.standard.integer(forKey: "SEQ_User"))&SEQ_Post=\(SEQ_Post!)&Post_owner=\(SEQ_Owner!)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil {
                print("error=\(error)")
                return
            }
            
            guard let resultData = data else { return }
            self.list = self.parse(data: resultData) ?? []
            self.feedlist = self.parsefeed(data: resultData) ?? []
            print("------> 카운트 \(self.list.count)")
            print("-----> feed count \(self.feedlist.count)")
            for user in self.list {
                self.PhotoName.append(user)
                }
            for feed in self.feedlist {
                print("---> feed : likeState : \(feed.likeState), likeCount : \(feed.likeCount)")
                self.likeState = feed.likeState
                self.likeCount = feed.likeCount
            }
            print("라벨 변경 전 : \(self.lbLikeCount.text!), \(self.likeCount)")
            self.lbLikeCount.text = "\(self.likeCount) 명이 좋아합니다."
            print("라벨 변경 : \(self.lbLikeCount.text!), \(self.likeCount)")
//            self.profileImage.sd_setImage(with: URL(string: <#T##String#>), completed: nil)
            self.setupImageView()
            if (self.likeState >= 1) {
//                print("빨간 이미지")
                self.likeImage.sd_setImage(with: URL(string: "http://112.149.7.38:8090/Final_Minimap/imageupload/like.png"), completed: nil)
            }else {
//                print("빈 이미지")
                self.likeImage.sd_setImage(with: URL(string: "http://112.149.7.38:8090/Final_Minimap/imageupload/unlike.png"), completed: nil)
            }
            self.pageControl.numberOfPages = self.list.count
            self.pageControl.currentPage = 0
        }
        task.resume()
    }

    func parse(data: Data) -> [String]? {
        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(FeedAllResponse.self, from: data)
            let FeedPhotoList = response.result
            return FeedPhotoList
        } catch let error {
            print("---> error : \(error.localizedDescription)")
            return nil
        }
    }
    
    func parsefeed(data: Data) -> [FeedInfo]? {
        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(FeedAllResponse.self, from: data)
            let FeedPhotoList = response.feed
            return FeedPhotoList
        } catch let error {
            print("---> error : \(error.localizedDescription)")
            return nil
        }
    }
    
    private func setupImageView(){
        imageView.sd_setImage(with: URL(string: "http://112.149.7.38:8090/Final_Minimap/imageupload/" + PhotoName[0]), completed: nil)
    }

    @IBAction func pageChange(_ sender: UIPageControl) {
        print("pageControl : \(pageControl.currentPage)")
        let url = URL(string: "http://112.149.7.38:8090/Final_Minimap/imageupload/" + PhotoName[pageControl.currentPage])
        let data = try? Data(contentsOf: url!)
        if let image = UIImage(data: data!){
            imageView.image = UIImage(data: data!)
        }
    }
    @IBAction func btnVerticalEllipsis(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let delete = UIAlertAction(title: "삭제", style: .destructive) { action in
            print("삭제")
        }
        
        let modify = UIAlertAction(title: "수정", style: .default) { action in
            print("수정")
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        actionSheet.addAction(delete)
        actionSheet.addAction(modify)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true, completion: nil)
    }
    @IBAction func btnLikeClicked(_ sender: UIButton) {
        if (likeState == 0) {
            print("좋아요 버튼 클릭!")
            let image = UIImage(named: "like.png")
            btnLike.setImage(image, for: .normal)
            
            
            let request = NSMutableURLRequest(url: NSURL(string: "http://112.149.7.38:8090/Final_Minimap/Ios/LikeAndUnlike.jsp")! as URL)
            
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            
            let postString = "SEQ_User=\(UserDefaults.standard.integer(forKey: "SEQ_User"))&SEQ_Post=\(SEQ_Post!)&Post_owner=\(SEQ_Owner!)&LikeState=\(likeState)"
            request.httpBody = postString.data(using: String.Encoding.utf8)
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                if error != nil {
                    print("---> error =\(error)")
                    return
                }
                let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            }
            task.resume()

            likeState = 1
        }else if (likeState == 1) {
            print("좋아요 취소 버튼 클릭!")
            let image = UIImage(named: "unlike.png")
            btnLike.setImage(image, for: .normal)
            
            let request = NSMutableURLRequest(url: NSURL(string: "http://112.149.7.38:8090/Final_Minimap/Ios/LikeAndUnlike.jsp")! as URL)
            
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            
            let postString = "SEQ_User=\(UserDefaults.standard.integer(forKey: "SEQ_User"))&SEQ_Post=\(SEQ_Post!)&Post_owner=\(SEQ_Owner!)&LikeState=\(likeState)"
            request.httpBody = postString.data(using: String.Encoding.utf8)
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                if error != nil {
                    print("---> error =\(error)")
                    return
                }
                let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            }
            task.resume()
            
            likeState = 0
        }
    }
    
}

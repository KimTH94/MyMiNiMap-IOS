//
//  FeedContainerViewController.swift
//  MyMiniMap
//
//  Created by TaeHwan Kim on 19/08/2019.
//  Copyright © 2019 TaeHwan Kim. All rights reserved.
//

import UIKit

struct FeedPhotoResponse: Codable {
    var result: [FeedPhoto]
}

struct FeedPhoto: Codable {
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

struct Item {
    var FileName: String
    var SEQ_Post: Int
    var SEQ_User: Int
}

class FeedContainerViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var FeedPhotoList: [FeedPhoto] = []
    var items: [Item] = []

    var SEQ_PostStack: Int = 0
    
    var SEQ_Owner: Int!
    
    var collectionViewFlowLayout: UICollectionViewFlowLayout!
    let cellIdentifier = "itemCollectionViewCell"
    let viewImageSegueidentifier = "abc"
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.reloadData()
        print("1. FeedContainerView SEQ_User : \(UserDefaults.standard.integer(forKey: "SEQ_User")), SEQ_Owner : \(SEQ_Owner)")
        
        if (SEQ_Owner == nil) {
            SEQ_Owner = UserDefaults.standard.integer(forKey: "SEQ_User")
        }
        print("2. FeedContainerView SEQ_User : \(UserDefaults.standard.integer(forKey: "SEQ_User")), SEQ_Owner : \(SEQ_Owner)")
        // Do any additional setup after loading the view.
        let request = NSMutableURLRequest(url: NSURL(string: "http://112.149.7.38:8090/Final_Minimap/Ios/FeedPhoto.jsp")! as URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "SEQ_User=\(SEQ_Owner!)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil {
                print("error=\(error)")
                return
            }
            
            guard let resultData = data else { return }
            self.FeedPhotoList = self.parse(data: resultData) ?? []
            
            print("------> 포토 리스트 카운트 \(self.FeedPhotoList.count)")
            for user in self.FeedPhotoList {
                if (self.SEQ_PostStack != user.SEQ_Post) {
                    self.items.append(Item(FileName: user.FileName, SEQ_Post: user.SEQ_Post, SEQ_User: user.SEQ_User))
                    self.SEQ_PostStack = user.SEQ_Post
                }
            }
            print("---> 아이템 리스트 카운트 : \(self.items.count)")
        }
        task.resume()
        
        setUpCollectionView()
    }
    
    func parse(data: Data) -> [FeedPhoto]? {
        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(FeedPhotoResponse.self, from: data)
            let FeedPhotoList = response.result
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
        let item = sender as! Item
        
        if segue.identifier == viewImageSegueidentifier {
            if let vc = segue.destination as? FullFeedViewController {
                vc.imageName = item.FileName
                vc.SEQ_Post = item.SEQ_Post
                vc.SEQ_User = item.SEQ_User
                vc.SEQ_Owner = SEQ_Owner
            }
        }
    }
    
    private func setUpCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        
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

extension FeedContainerViewController: UICollectionViewDataSource, UICollectionViewDelegate{
   
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
        performSegue(withIdentifier: viewImageSegueidentifier, sender: item)
    }
}

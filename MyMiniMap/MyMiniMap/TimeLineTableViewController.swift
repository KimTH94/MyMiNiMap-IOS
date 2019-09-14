//
//  TimeLineTableViewController.swift
//  MyMiniMap
//
//  Created by TaeHwan Kim on 06/09/2019.
//  Copyright © 2019 TaeHwan Kim. All rights reserved.
//

import UIKit
import SDWebImage

struct FeedMainResponse: Codable {
    var result: [FeedMain]
    var user: [UserFeed]
}

struct FeedMain: Codable {
    var FileName: String
    var Nickname: String
    var SEQ_Post: Int
    var Profile: String
}

struct UserFeed: Codable {
    let SEQ_User: Int
    let Name: String
    let Nickname: String
    let FileName: String
}

protocol SendDataDelegate {
    func sendData(data: Int)
}

class TimeLineTableViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var FeedView: UITableView!
    @IBOutlet weak var SearchView: UITableView!
    
    var NewsFeedList: [FeedMain] = []
    var SearchUserList: [UserFeed] = []
    
    var searchUser = [UserFeed]()
    var searching = false
    var SEQ_Owner: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://112.149.7.38:8090/Final_Minimap/Ios/NewsFeed.jsp")! as URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil {
                print("error=\(error)")
                return
            }
            
            guard let resultData = data else { return }
            
            self.NewsFeedList = self.parse(data: resultData) ?? []
            self.SearchUserList = self.parseUser(data: resultData) ?? []
            
            self.FeedView.delegate = self
            self.FeedView.dataSource = self
            self.SearchView.delegate = self
            self.SearchView.dataSource = self
            self.searchBar.delegate = self
            
            print("------> 포토 리스트 카운트 \(self.NewsFeedList.count)")
            print("------> 유저 리스트 카운트 \(self.SearchUserList.count)")
            
            DispatchQueue.main.async {
               // self.seachBarView.reloadData()
                self.FeedView.reloadData()
            }
            
            for feed in self.SearchUserList {
                print("---> feed : FileName : \(feed.FileName), Nickname : \(feed.Nickname), Name: \(feed.Name), SEQ_User : \(feed.SEQ_User)")

            }
            }
            task.resume()
        }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "goFeed1" {
//            if let vc = segue.destination as? MyFeedViewController {
//                vc.SEQ_Owner = SEQ_Owner
//            }
//            print("이동")
//        }
//    }
    
        func parse(data: Data) -> [FeedMain]? {
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(FeedMainResponse.self, from: data)
                let List = response.result
                return List
            } catch let error {
                print("---> error : \(error.localizedDescription)")
                return nil
            }
        }
    
        func parseUser(data: Data) -> [UserFeed]? {
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(FeedMainResponse.self, from: data)
                let List = response.user
                return List
            } catch let error {
                print("---> error : \(error.localizedDescription)")
                return nil
            }
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "go" {
            var param = segue.destination as! MyFeedViewController
            param.SEQ_Owner = self.SEQ_Owner
        }
    }
}

extension TimeLineTableViewController : UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == SearchView {
            if searching {
                return searchUser.count
            }else {
                return SearchUserList.count
            }
        }else {
            return NewsFeedList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == FeedView {
            let cell = FeedView.dequeueReusableCell(withIdentifier: "Post", for: indexPath) as! Post
            print("\(NewsFeedList[indexPath.row].Profile)")
            cell.proFileImage.sd_setImage(with: URL(string: "http://112.149.7.38:8090/Final_Minimap/imageupload/" + NewsFeedList[indexPath.row].Profile), completed: nil)
            cell.mainImage.sd_setImage(with: URL(string: "http://112.149.7.38:8090/Final_Minimap/imageupload/" + NewsFeedList[indexPath.row].FileName), completed: nil)
            cell.lbInfo.text = "\(NewsFeedList[indexPath.row].Nickname)"
            cell.btnLike.sd_setBackgroundImage(with: URL(string: "http://112.149.7.38:8090/Final_Minimap/imageupload/like.png"), for: UIControl.State.normal, completed: nil)
            cell.cellDelegate = self
            cell.index = NewsFeedList[indexPath.row].SEQ_Post
            cell.result = "좋아"
            return cell
        }
        else {
            let cell = SearchView.dequeueReusableCell(withIdentifier: "su", for: indexPath) as! SearchUser
            if searching {
                cell.profileImage.sd_setImage(with: URL(string: "http://112.149.7.38:8090/Final_Minimap/imageupload/" + searchUser[indexPath.row].FileName), completed: nil)
                cell.lbName.text = "\(searchUser[indexPath.row].Name)"
                cell.lbNickname.text = "\(searchUser[indexPath.row].Nickname)"
            }else {
                cell.profileImage.sd_setImage(with: URL(string: "http://112.149.7.38:8090/Final_Minimap/imageupload/" + SearchUserList[indexPath.row].FileName), completed: nil)
                cell.lbName.text = "\(SearchUserList[indexPath.row].Name)"
                cell.lbNickname.text = "\(SearchUserList[indexPath.row].Nickname)"
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == FeedView {
            print("나는 피드 뷰다 깝치지 마라 : \(NewsFeedList[indexPath.row])")
        }else {
            print("나는 서치 뷰다 \(SearchUserList[indexPath.row].Nickname)")
            SEQ_Owner = SearchUserList[indexPath.row].SEQ_User
            self.performSegue(withIdentifier: "go", sender: self)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == FeedView {
            return 600
        }else {
            return 100
        }

    }
}

extension TimeLineTableViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("검색 시작")
        self.searchBar.showsCancelButton = true
        FeedView.isHidden = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("검색 취소")
        self.searchBar.showsCancelButton = false
        self.searchBar.text = ""
        self.searchBar.resignFirstResponder()
        FeedView.isHidden = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchBar : \(searchText)")
        searchUser = SearchUserList.filter({$0.Nickname.prefix(searchText.count) == searchText})
        searching = true
        SearchView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("\(searchBar)")
    }
}

extension TimeLineTableViewController: TableViewNew {
    func onClickCell(index: Int) {
        print("\(index) is Click")
    }
    
    func onLikeButtonClick(result: String) {
        print("하트 버튼 누르시오 : \(result)")
    }
}


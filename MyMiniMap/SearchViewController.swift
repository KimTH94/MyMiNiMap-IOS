//
//  SearchViewController.swift
//  MyMiniMap
//
//  Created by TaeHwan Kim on 22/08/2019.
//  Copyright © 2019 TaeHwan Kim. All rights reserved.
//

import UIKit

struct Search1: Codable {
    var user: [UserBySearch1]
}
struct UserBySearch1: Codable {
    let SEQ_User: Int
    let Name: String
    let Nickname: String
    let FileName: String
}

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    var userArray = [UserBySearch1]()
    var currentUserArray = [UserBySearch1]()
    
    var userList: [UserBySearch1] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        setUpAnimals()
        setUpUsers()
    }
    
    private func setUpUsers(){
        
        func parse(data: Data) -> [UserBySearch1]? {
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Search1.self, from: data)
                let userList = response.user
                return userList
            } catch let error {
                print("---> error : \(error.localizedDescription)")
                return nil
            }
        }
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://112.149.7.38:8090/Final_Minimap/Ios/SearchUser.jsp")! as URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
//        let postString = "email=\(email.text!)&password=\(password.text!)"
//        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil {
                print("error=\(error)")
                return
            }
            
            guard let resultData = data else { return }
            self.userArray = parse(data: resultData) ?? []
            for user in self.userList {
                print("SEQ_User : \(user.SEQ_User)")
                print("Nickname : \(user.Nickname)")
                print("Name : \(user.Name)")
                print("FileName : \(user.FileName)")
            }
        }
        task.resume()
        
        currentUserArray = userArray
    }
//
//    private func setUpAnimals(){
//        //CATS
//        animalArray.append(Animal(name: "Amber", image: "1.jpeg", category: .cat))
//        animalArray.append(Animal(name: "bAsers", image: "2.jpeg", category: .cat))
//        animalArray.append(Animal(name: "cesee", image: "3.jpeg", category: .cat))
//        animalArray.append(Animal(name: "grdAede", image: "4.jpeg", category: .cat))
//        animalArray.append(Animal(name: "mkmdee", image: "5.jpeg", category: .cat))
//        animalArray.append(Animal(name: "fgmlsdf", image: "6.jpeg", category: .cat))
//        animalArray.append(Animal(name: "qerlAmd", image: "7.jpeg", category: .cat))
//        animalArray.append(Animal(name: "besfe", image: "8.jpeg", category: .cat))
//        //DOGS
//        animalArray.append(Animal(name: "brseeA", image: "9.jpeg", category: .dog))
//        animalArray.append(Animal(name: "bdyerf", image: "10.jpeg", category: .dog))
//        animalArray.append(Animal(name: "hferAe", image: "11.jpeg", category: .dog))
//        animalArray.append(Animal(name: "jrghfg", image: "12.jpeg", category: .dog))
//        animalArray.append(Animal(name: "bdrAtr", image: "13.jpeg", category: .dog))
//        animalArray.append(Animal(name: "werwer", image: "14.jpeg", category: .dog))
//        animalArray.append(Animal(name: "etrtre", image: "15.jpeg", category: .dog))
//
//        currentAnimalArray = animalArray
//    }
    
    private func setUpSearch(){
        searchBar.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return currentAnimalArray.count
        return currentUserArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell") as? SearchTableCell else {
            return UITableViewCell()
        }
//        cell.lbEmail.text = currentAnimalArray[indexPath.row].name
//        cell.lbNickname.text = currentAnimalArray[indexPath.row].category.rawValue
//        cell.TableImageView.image = UIImage(named: currentAnimalArray[indexPath.row].image)
        cell.lbEmail.text = currentUserArray[indexPath.row].Name
        cell.lbNickname.text = currentUserArray[indexPath.row].Nickname
        let url = URL(string: "http://112.149.7.38:8090/Final_Minimap/imageupload/default.png")
        let data = try? Data(contentsOf: url!)
        cell.TableImageView.image = UIImage(data: data!)
//        cell.TableImageView.image = UIImage(named: currentUserArray[indexPath.row].image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    //Search Bar
    func searchBar(_ tableView: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            currentUserArray = userArray
            table.reloadData()
            return
        }
        
        currentUserArray = userArray.filter({ (UserBySearch) -> Bool in
            return UserBySearch.Name.contains(searchText)
        })
        table.reloadData()
    }
    
    func searchBar(_ tableView: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        print("클릭 \(selectedScope)")
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

class UserBySearch {
    let SEQ_User: Int
    let Name: String
    let Nickname: String
    let image: String
    
    init(SEQ_User: Int, Name: String, Nickname: String, image: String) {
        self.SEQ_User = SEQ_User
        self.Name = Name
        self.Nickname = Nickname
        self.image = image
    }
}

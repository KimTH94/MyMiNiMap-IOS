//
//  ViewController.swift
//  MyMiniMap
//
//  Created by TaeHwan Kim on 12/07/2019.
//  Copyright © 2019 TaeHwan Kim. All rights reserved.
//

import UIKit
import Alamofire

struct Response: Codable {
    var result: [User]
}

struct User: Codable {
    var loginResult: Int
    var SEQ_User: Int
}

class ViewController: UIViewController {
    
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    
    @IBOutlet var btnLogin: UIButton!
    
    @IBAction func submit(_ sender: UIButton) {
        
        func parse(data: Data) -> [User]? {
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Response.self, from: data)
                let userList = response.result
                return userList
            } catch let error {
                print("---> error : \(error.localizedDescription)")
                return nil
            }
        }
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://112.149.7.38:8090/Final_Minimap/Ios/Login.jsp")! as URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "email=\(email.text!)&password=\(password.text!)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil {
                print("error=\(error)")
                return
            }
            
            var userList: [User] = []
            
            guard let resultData = data else { return }
            userList = parse(data: resultData) ?? []
            for user in userList {
                print("loginResult : \(user.loginResult)")
                print("SEQ_User : \(user.SEQ_User)")
            }
            
            if userList[0].loginResult == 1 {
                print("로그인 성공")
                UserDefaults.standard.set(userList[0].SEQ_User, forKey: "SEQ_User")
                DispatchQueue.main.async(execute: {
                    let storyboard: UIStoryboard = self.storyboard!
                    let nextView = storyboard.instantiateViewController(withIdentifier: "a")
                    self.present(nextView, animated: true, completion: nil)
                })
            } else {
                print("로그인 실패")
            }
        }
        task.resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        email.borderStyle = UITextField.BorderStyle.roundedRect
        password.borderStyle = UITextField.BorderStyle.roundedRect
        btnLogin.layer.cornerRadius = 7
        email.text = "kovo1234@naver.com"
        password.text = "1234"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


//
//  UserJoinController.swift
//  MyMiniMap
//
//  Created by TaeHwan Kim on 31/07/2019.
//  Copyright © 2019 TaeHwan Kim. All rights reserved.
//

import UIKit

class UserJoinController: UIViewController {

    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var txtPasswordConfirm: UITextField!
    @IBOutlet var txtNickname: UITextField!
    @IBOutlet var txtName: UITextField!

    @IBOutlet var lbEmail: UILabel!
    @IBOutlet var lbPassword: UILabel!
    @IBOutlet var lbPasswordConfirm: UILabel!
    @IBOutlet var lbNickname: UILabel!
    @IBOutlet var lbName: UILabel!

    
    @IBOutlet var btnUserJoin: UIButton!
    @IBOutlet var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        txtEmail.borderStyle = UITextField.BorderStyle.roundedRect
        txtPassword.borderStyle = UITextField.BorderStyle.roundedRect
        txtPasswordConfirm.borderStyle = UITextField.BorderStyle.roundedRect
        txtNickname.borderStyle = UITextField.BorderStyle.roundedRect
        txtName.borderStyle = UITextField.BorderStyle.roundedRect
        
        btnUserJoin.layer.cornerRadius = 7
        btnLogin.layer.cornerRadius = 7
    }
    
    @IBAction func btnUserJoin(_ sender: UIButton) {
        
        var emailValidation = false
        var passwordValidation = false
        var nicknameValidation = false
        var nameValidation = false
        var equalPassword = false
        
        if txtEmail.text!.isEmpty {
            lbEmail.text = " Email을 입력해주세요..."
        }else {
            lbEmail.text = ""
            emailValidation = true
        }
        
        if txtPassword.text!.isEmpty {
            lbPassword.text = " 비밀번호를 입력해주세요..."
        }else {
            lbPassword.text = ""
            passwordValidation = true
        }
        
        if txtNickname.text!.isEmpty {
            lbNickname.text = " 닉네임을 입력해주세요..."
        }else {
            lbNickname.text = ""
            nicknameValidation = true
        }
        
        if txtName.text!.isEmpty {
            lbName.text = " 이름을 입력해주세요..."
        }else {
            lbName.text = ""
            nameValidation = true
        }
        
        if txtPassword.text!.isEqual(txtPasswordConfirm.text!){
            if txtPasswordConfirm.text!.isEmpty {
                lbPasswordConfirm.text = "비밀번호를 입력해주세요..."
            }else {
                lbPasswordConfirm.text = ""
                equalPassword = true
            }
        }else {
            lbPasswordConfirm.text = " 비밀번호가 일치하지 않습니다..."
        }
        
        if emailValidation , passwordValidation, nicknameValidation, nameValidation, equalPassword {
            let request = NSMutableURLRequest(url: NSURL(string: "http://112.149.7.38:8090/Final_Minimap/UserJoin")! as URL)
            
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            
            let postString = "email=\(txtEmail.text!)&password=\(txtPassword.text!)&name=\(txtName.text!)&nickname=\(txtNickname.text!)"
            
            request.httpBody = postString.data(using: String.Encoding.utf8)
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                
                if error != nil {
                    print("---> error =\(error)")
                    return
                }
                
                print("---> response = \(response)")
                
                let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("responseString = \(responseString!)")
            }
            task.resume()
            
            
            let alertController = UIAlertController(title: nil, message:
                "회원가입 성공!", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func CheckPassword(_ sender: Any) {
        if txtPassword.text!.isEmpty {
            let redColor: UIColor = .red
            txtPassword.layer.borderColor = redColor.cgColor
            txtPassword.layer.borderWidth = 1.0
            print("비밀번호 먼저 입력.")
        } else {
            print("---> password :  \(txtPassword.text!)")
            print("---> password Confirm : \(txtPasswordConfirm.text!)")
        }
        

    }
    
}

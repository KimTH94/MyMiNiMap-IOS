//
//  SaveRestaurantViewController.swift
//  MyMiniMap
//
//  Created by TaeHwan Kim on 10/08/2019.
//  Copyright © 2019 TaeHwan Kim. All rights reserved.
//

import UIKit
import Alamofire
import Photos
import BSImagePicker

class SaveRestaurantViewController: UIViewController, UITextFieldDelegate {

    var name = ""
    var address = ""
    var latitude = ""
    var longitude = ""
    var id = ""

    var saveType: Int = 0
    var foodType: Int = 0
    var alcoholType: Int = 0
    var cafeType: Int = 0
    
    var recommendState: Int = 0
    var placeRecommendState: Int = 0
    
    var companyType: Int = 0
    var placeCompanyType: Int = 0
    
    var price: Int = 0
    
    var recommendMene: String = ""
    
    var tag: String = ""
    var placeTag: String = ""
    var SaveTag: String = ""

    var companyString: String = "0,"
    var placeCompanyString: String = "0,"
    
    var btnAloneState: Int = 0
    var btnFriendState: Int = 0
    var btnCoupleState: Int = 0
    var btnDiningTogetherState: Int = 0
    var btnBusinessState: Int = 0
    var btnFamilyState: Int = 0
    
    var btnPlaceAloneState: Int = 0
    var btnPlaceFriendState: Int = 0
    var btnPlaceCoupleState: Int = 0
    var btnPlaceDiningTogetherState: Int = 0
    var btnPlaceBusinessState: Int = 0
    var btnPlaceFamilyState: Int = 0
    
    @IBOutlet weak var txtAddress: UITextField!
    
    @IBOutlet var imgView: UIImageView!
    
    @IBOutlet weak var vFood1: UIView!
    @IBOutlet weak var vCafe1: UIView!
    @IBOutlet weak var vAlcohol1: UIView!
    @IBOutlet weak var vSave1: UIView!
    @IBOutlet weak var vPlace1: UIView!
    
    @IBOutlet weak var vPlaceTag: UIView!
    
    @IBOutlet weak var vRecommend: UIView!
    @IBOutlet weak var vCompany: UIView!
    @IBOutlet weak var vPrice: UIView!
    @IBOutlet weak var vMenu: UIView!
    @IBOutlet weak var vTag: UIView!
    
    @IBOutlet weak var vPlaceCompany: UIView!
    
    @IBOutlet weak var btnTypeFood: UIButton!
    @IBOutlet weak var btnTypeCafe: UIButton!
    @IBOutlet weak var btnTypeAlcohol: UIButton!
    @IBOutlet weak var btnTypePlace: UIButton!
    @IBOutlet weak var btnTypeSave: UIButton!
    
    @IBOutlet weak var btnKoreanFood: UIButton!
    @IBOutlet weak var btnChineseFood: UIButton!
    @IBOutlet weak var btnJapaneseFood: UIButton!
    @IBOutlet weak var btnWesternFood: UIButton!
    @IBOutlet weak var btnSouthAsianFood: UIButton!
    @IBOutlet weak var btnLateNightMeal: UIButton!
    @IBOutlet weak var btnFlourBasedFood: UIButton!
    
    @IBOutlet weak var btnThemeCafe: UIButton!
    @IBOutlet weak var btnSentimentalCafe: UIButton!
    @IBOutlet weak var btnBrunch: UIButton!
    @IBOutlet weak var btnPetCafe: UIButton!
    
    @IBOutlet weak var btnKoreanAlcohol: UIButton!
    @IBOutlet weak var btnChineseAlcohol: UIButton!
    @IBOutlet weak var btnJapaneseAlcohol: UIButton!
    @IBOutlet weak var btnModernBar: UIButton!
    @IBOutlet weak var btnWine: UIButton!
    @IBOutlet weak var btnStreetAlcohol: UIButton!
    
    @IBOutlet weak var btnPlaceRecommend: UIButton!
    @IBOutlet weak var btnPlaceNonRecommend: UIButton!
    
    @IBOutlet weak var btnRecommend: UIButton!
    @IBOutlet weak var btnNonRecommend: UIButton!
    
    @IBOutlet weak var btnAlone: UIButton!
    @IBOutlet weak var btnFriend: UIButton!
    @IBOutlet weak var btnCouple: UIButton!
    @IBOutlet weak var btnDiningTogether: UIButton!
    @IBOutlet weak var btnBusiness: UIButton!
    @IBOutlet weak var btnFamily: UIButton!
    
    @IBOutlet weak var btnPlaceAlone: UIButton!
    @IBOutlet weak var btnPlaceFriend: UIButton!
    @IBOutlet weak var btnPlaceCouple: UIButton!
    @IBOutlet weak var btnPlaceDiningTogether: UIButton!
    @IBOutlet weak var btnPlaceBusiness: UIButton!
    @IBOutlet weak var btnPlaceFamily: UIButton!
    
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var sliderPrice: UISlider!
    
    @IBOutlet weak var txtSaveTag: UITextField!
    @IBOutlet weak var txtPlaceTag: UITextField!
    @IBOutlet weak var txtMenu: UITextField!
    @IBOutlet weak var txtTag: UITextField!
    
    var SelectedAssets = [PHAsset]()
    var PhotoArray = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtAddress.text = address
        
        vFood1.isHidden = false
        vCafe1.isHidden = true
        vAlcohol1.isHidden = true
        vPlace1.isHidden = true
        vSave1.isHidden = true
        vMenu.isHidden = false
        vTag.isHidden = false
        
        vPlaceCompany.isHidden = true
        vPlaceTag.isHidden = true
        
        btnTypeFood.layer.cornerRadius = 5
        btnTypeFood.contentHorizontalAlignment = .center
        btnTypeCafe.layer.cornerRadius = 5
        btnTypeCafe.contentHorizontalAlignment = .center
        btnTypeAlcohol.layer.cornerRadius = 5
        btnTypeAlcohol.contentHorizontalAlignment = .center
        btnTypePlace.layer.cornerRadius = 5
        btnTypePlace.contentHorizontalAlignment = .center
        btnTypeSave.layer.cornerRadius = 5
        btnTypeSave.contentHorizontalAlignment = .center
        
        btnKoreanFood.layer.cornerRadius = 5
        btnKoreanFood.contentHorizontalAlignment = .center
        btnChineseFood.layer.cornerRadius = 5
        btnChineseFood.contentHorizontalAlignment = .center
        btnJapaneseFood.layer.cornerRadius = 5
        btnJapaneseFood.contentHorizontalAlignment = .center
        btnWesternFood.layer.cornerRadius = 5
        btnWesternFood.contentHorizontalAlignment = .center
        btnSouthAsianFood.layer.cornerRadius = 5
        btnSouthAsianFood.contentHorizontalAlignment = .center
        btnLateNightMeal.layer.cornerRadius = 5
        btnLateNightMeal.contentHorizontalAlignment = .center
        btnFlourBasedFood.layer.cornerRadius = 5
        btnFlourBasedFood.contentHorizontalAlignment = .center
        
        btnThemeCafe.layer.cornerRadius = 5
        btnThemeCafe.contentHorizontalAlignment = .center
        btnSentimentalCafe.layer.cornerRadius = 5
        btnSentimentalCafe.contentHorizontalAlignment = .center
        btnBrunch.layer.cornerRadius = 5
        btnBrunch.contentHorizontalAlignment = .center
        btnPetCafe.layer.cornerRadius = 5
        btnPetCafe.contentHorizontalAlignment = .center
        
        btnKoreanAlcohol.layer.cornerRadius = 5
        btnKoreanAlcohol.contentHorizontalAlignment = .center
        btnChineseAlcohol.layer.cornerRadius = 5
        btnChineseAlcohol.contentHorizontalAlignment = .center
        btnJapaneseAlcohol.layer.cornerRadius = 5
        btnJapaneseAlcohol.contentHorizontalAlignment = .center
        btnModernBar.layer.cornerRadius = 5
        btnModernBar.contentHorizontalAlignment = .center
        btnWine.layer.cornerRadius = 5
        btnWine.contentHorizontalAlignment = .center
        btnStreetAlcohol.layer.cornerRadius = 5
        btnStreetAlcohol.contentHorizontalAlignment = .center
        
        btnPlaceRecommend.layer.cornerRadius = 5
        btnPlaceRecommend.contentHorizontalAlignment = .center
        btnPlaceNonRecommend.layer.cornerRadius = 5
        btnPlaceNonRecommend.contentHorizontalAlignment = .center
        
        btnRecommend.layer.cornerRadius = 5
        btnRecommend.contentHorizontalAlignment = .center
        btnNonRecommend.layer.cornerRadius = 5
        btnNonRecommend.contentHorizontalAlignment = .center
        
        btnAlone.layer.cornerRadius = 5
        btnAlone.contentHorizontalAlignment = .center
        btnFriend.layer.cornerRadius = 5
        btnFriend.contentHorizontalAlignment = .center
        btnCouple.layer.cornerRadius = 5
        btnCouple.contentHorizontalAlignment = .center
        btnDiningTogether.layer.cornerRadius = 5
        btnDiningTogether.contentHorizontalAlignment = .center
        btnBusiness.layer.cornerRadius = 5
        btnBusiness.contentHorizontalAlignment = .center
        btnFamily.layer.cornerRadius = 5
        btnFamily.contentHorizontalAlignment = .center
        
        btnPlaceAlone.layer.cornerRadius = 5
        btnPlaceAlone.contentHorizontalAlignment = .center
        btnPlaceFriend.layer.cornerRadius = 5
        btnPlaceFriend.contentHorizontalAlignment = .center
        btnPlaceCouple.layer.cornerRadius = 5
        btnPlaceCouple.contentHorizontalAlignment = .center
        btnPlaceDiningTogether.layer.cornerRadius = 5
        btnPlaceDiningTogether.contentHorizontalAlignment = .center
        btnPlaceBusiness.layer.cornerRadius = 5
        btnPlaceBusiness.contentHorizontalAlignment = .center
        btnPlaceFamily.layer.cornerRadius = 5
        btnPlaceFamily.contentHorizontalAlignment = .center
        
        imgView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.addImg(_:)))
        imgView.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapGesture(){
        print("tap")
    }
    @IBAction func btnTypeFoodClicked(_ sender: UIButton) {
        vFood1.isHidden = false
        vCafe1.isHidden = true
        vAlcohol1.isHidden = true
        vPlace1.isHidden = true
        vSave1.isHidden = true
        vMenu.isHidden = false
        vTag.isHidden = false
        
        vRecommend.isHidden = false
        vCompany.isHidden = false
        vPrice.isHidden = false
        
        vPlaceCompany.isHidden = true
        vPlaceTag.isHidden = true
        
        btnTypeFood.layer.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        btnTypeFood.setTitleColor(.white, for: .normal)
        btnTypeCafe.layer.backgroundColor = UIColor.white.cgColor
        btnTypeCafe.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnTypeAlcohol.layer.backgroundColor = UIColor.white.cgColor
        btnTypeAlcohol.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnTypePlace.layer.backgroundColor = UIColor.white.cgColor
        btnTypePlace.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnTypeSave.layer.backgroundColor = UIColor.white.cgColor
        btnTypeSave.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        
        saveType = 1
    }
    
    @IBAction func btnTypeCafeClicked(_ sender: UIButton) {
        vFood1.isHidden = true
        vCafe1.isHidden = false
        vAlcohol1.isHidden = true
        vPlace1.isHidden = true
        vSave1.isHidden = true
        vMenu.isHidden = false
        vTag.isHidden = false
        
        vRecommend.isHidden = false
        vCompany.isHidden = false
        vPrice.isHidden = false

        vPlaceCompany.isHidden = true
        vPlaceTag.isHidden = true

        btnTypeCafe.layer.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        btnTypeCafe.setTitleColor(.white, for: .normal)
        btnTypeFood.layer.backgroundColor = UIColor.white.cgColor
        btnTypeFood.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnTypeAlcohol.layer.backgroundColor = UIColor.white.cgColor
        btnTypeAlcohol.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnTypePlace.layer.backgroundColor = UIColor.white.cgColor
        btnTypePlace.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnTypeSave.layer.backgroundColor = UIColor.white.cgColor
        btnTypeSave.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        
        saveType = 2
    }
    
    @IBAction func btnTypeAlcoholClicked(_ sender: UIButton) {
        vFood1.isHidden = true
        vCafe1.isHidden = true
        vAlcohol1.isHidden = false
        vPlace1.isHidden = true
        vSave1.isHidden = true
        vMenu.isHidden = false
        vTag.isHidden = false
        
        vRecommend.isHidden = false
        vCompany.isHidden = false
        vPrice.isHidden = false

        vPlaceCompany.isHidden = true
        vPlaceTag.isHidden = true

        btnTypeAlcohol.layer.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        btnTypeAlcohol.setTitleColor(.white, for: .normal)
        btnTypeFood.layer.backgroundColor = UIColor.white.cgColor
        btnTypeFood.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnTypeCafe.layer.backgroundColor = UIColor.white.cgColor
        btnTypeCafe.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnTypePlace.layer.backgroundColor = UIColor.white.cgColor
        btnTypePlace.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnTypeSave.layer.backgroundColor = UIColor.white.cgColor
        btnTypeSave.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        
        saveType = 3
    }

    @IBAction func btnTypePlaceClicked(_ sender: UIButton) {
        vFood1.isHidden = true
        vCafe1.isHidden = true
        vAlcohol1.isHidden = true
        vPlace1.isHidden = false
        vSave1.isHidden = true
        vMenu.isHidden = true
        vTag.isHidden = true
        
        vRecommend.isHidden = true
        vCompany.isHidden = true
        vPrice.isHidden = true
        
        vPlaceCompany.isHidden = false
        vPlaceTag.isHidden = false

        btnTypePlace.layer.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        btnTypePlace.setTitleColor(.white, for: .normal)
        btnTypeFood.layer.backgroundColor = UIColor.white.cgColor
        btnTypeFood.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnTypeCafe.layer.backgroundColor = UIColor.white.cgColor
        btnTypeCafe.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnTypeAlcohol.layer.backgroundColor = UIColor.white.cgColor
        btnTypeAlcohol.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnTypeSave.layer.backgroundColor = UIColor.white.cgColor
        btnTypeSave.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        
        saveType = 4
    }
    
    @IBAction func btnTypeSaveClicked(_ sender: UIButton) {
        vFood1.isHidden = true
        vCafe1.isHidden = true
        vAlcohol1.isHidden = true
        vPlace1.isHidden = true
        vSave1.isHidden = false
        vMenu.isHidden = true
        vTag.isHidden = true
        
        vRecommend.isHidden = true
        vCompany.isHidden = true
        vPrice.isHidden = true

        vPlaceCompany.isHidden = true
        vPlaceTag.isHidden = true

        btnTypeSave.layer.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        btnTypeSave.setTitleColor(.white, for: .normal)
        btnTypeFood.layer.backgroundColor = UIColor.white.cgColor
        btnTypeFood.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnTypeCafe.layer.backgroundColor = UIColor.white.cgColor
        btnTypeCafe.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnTypeAlcohol.layer.backgroundColor = UIColor.white.cgColor
        btnTypeAlcohol.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnTypePlace.layer.backgroundColor = UIColor.white.cgColor
        btnTypePlace.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        
        saveType = 5
    }
    
    @IBAction func btnKoreanFoodClicked(_ sender: UIButton) {
        btnKoreanFood.layer.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        btnKoreanFood.setTitleColor(.white, for: .normal)
        btnJapaneseFood.layer.backgroundColor = UIColor.white.cgColor
        btnJapaneseFood.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnChineseFood.layer.backgroundColor = UIColor.white.cgColor
        btnChineseFood.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnWesternFood.layer.backgroundColor = UIColor.white.cgColor
        btnWesternFood.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnSouthAsianFood.layer.backgroundColor = UIColor.white.cgColor
        btnSouthAsianFood.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnLateNightMeal.layer.backgroundColor = UIColor.white.cgColor
        btnLateNightMeal.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnFlourBasedFood.layer.backgroundColor = UIColor.white.cgColor
        btnFlourBasedFood.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        
        foodType = 1
    }
    
    @IBAction func btnChineseFoodClicked(_ sender: UIButton) {
        btnChineseFood.layer.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        btnChineseFood.setTitleColor(.white, for: .normal)
        btnJapaneseFood.layer.backgroundColor = UIColor.white.cgColor
        btnJapaneseFood.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnKoreanFood.layer.backgroundColor = UIColor.white.cgColor
        btnKoreanFood.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnWesternFood.layer.backgroundColor = UIColor.white.cgColor
        btnWesternFood.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnSouthAsianFood.layer.backgroundColor = UIColor.white.cgColor
        btnSouthAsianFood.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnLateNightMeal.layer.backgroundColor = UIColor.white.cgColor
        btnLateNightMeal.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnFlourBasedFood.layer.backgroundColor = UIColor.white.cgColor
        btnFlourBasedFood.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        
        foodType = 2
    }
    
    @IBAction func btnJapaneseFoodClicked(_ sender: UIButton) {
        btnJapaneseFood.layer.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        btnJapaneseFood.setTitleColor(.white, for: .normal)
        btnKoreanFood.layer.backgroundColor = UIColor.white.cgColor
        btnKoreanFood.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnChineseFood.layer.backgroundColor = UIColor.white.cgColor
        btnChineseFood.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnWesternFood.layer.backgroundColor = UIColor.white.cgColor
        btnWesternFood.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnSouthAsianFood.layer.backgroundColor = UIColor.white.cgColor
        btnSouthAsianFood.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnLateNightMeal.layer.backgroundColor = UIColor.white.cgColor
        btnLateNightMeal.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnFlourBasedFood.layer.backgroundColor = UIColor.white.cgColor
        btnFlourBasedFood.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        
        foodType = 3
    }
    
    @IBAction func btnWesternFoodClicked(_ sender: UIButton) {
        btnWesternFood.layer.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        btnWesternFood.setTitleColor(.white, for: .normal)
        btnJapaneseFood.layer.backgroundColor = UIColor.white.cgColor
        btnJapaneseFood.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnChineseFood.layer.backgroundColor = UIColor.white.cgColor
        btnChineseFood.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnKoreanFood.layer.backgroundColor = UIColor.white.cgColor
        btnKoreanFood.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnSouthAsianFood.layer.backgroundColor = UIColor.white.cgColor
        btnSouthAsianFood.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnLateNightMeal.layer.backgroundColor = UIColor.white.cgColor
        btnLateNightMeal.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnFlourBasedFood.layer.backgroundColor = UIColor.white.cgColor
        btnFlourBasedFood.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        
        foodType = 4
    }
    
    @IBAction func btnSoutheastAsianFoodClicked(_ sender: UIButton) {
        btnSouthAsianFood.layer.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        btnSouthAsianFood.setTitleColor(.white, for: .normal)
        btnJapaneseFood.layer.backgroundColor = UIColor.white.cgColor
        btnJapaneseFood.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnChineseFood.layer.backgroundColor = UIColor.white.cgColor
        btnChineseFood.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnWesternFood.layer.backgroundColor = UIColor.white.cgColor
        btnWesternFood.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnKoreanFood.layer.backgroundColor = UIColor.white.cgColor
        btnKoreanFood.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnLateNightMeal.layer.backgroundColor = UIColor.white.cgColor
        btnLateNightMeal.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnFlourBasedFood.layer.backgroundColor = UIColor.white.cgColor
        btnFlourBasedFood.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        
        foodType = 5
    }
    
    @IBAction func btnLateNightMealClicked(_ sender: UIButton) {
        btnLateNightMeal.layer.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        btnLateNightMeal.setTitleColor(.white, for: .normal)
        btnJapaneseFood.layer.backgroundColor = UIColor.white.cgColor
        btnJapaneseFood.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnChineseFood.layer.backgroundColor = UIColor.white.cgColor
        btnChineseFood.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnWesternFood.layer.backgroundColor = UIColor.white.cgColor
        btnWesternFood.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnSouthAsianFood.layer.backgroundColor = UIColor.white.cgColor
        btnSouthAsianFood.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnKoreanFood.layer.backgroundColor = UIColor.white.cgColor
        btnKoreanFood.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnFlourBasedFood.layer.backgroundColor = UIColor.white.cgColor
        btnFlourBasedFood.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        
        foodType = 6
    }
    
    @IBAction func btnFlourBasedFood(_ sender: UIButton) {
        btnFlourBasedFood.layer.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        btnFlourBasedFood.setTitleColor(.white, for: .normal)
        btnJapaneseFood.layer.backgroundColor = UIColor.white.cgColor
        btnJapaneseFood.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnChineseFood.layer.backgroundColor = UIColor.white.cgColor
        btnChineseFood.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnWesternFood.layer.backgroundColor = UIColor.white.cgColor
        btnWesternFood.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnSouthAsianFood.layer.backgroundColor = UIColor.white.cgColor
        btnSouthAsianFood.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnLateNightMeal.layer.backgroundColor = UIColor.white.cgColor
        btnLateNightMeal.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnKoreanFood.layer.backgroundColor = UIColor.white.cgColor
        btnKoreanFood.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        
        foodType = 7
    }
    
    @IBAction func btnThemeCafeClicked(_ sender: UIButton) {
        btnThemeCafe.layer.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        btnThemeCafe.setTitleColor(.white, for: .normal)
        btnSentimentalCafe.layer.backgroundColor = UIColor.white.cgColor
        btnSentimentalCafe.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnBrunch.layer.backgroundColor = UIColor.white.cgColor
        btnBrunch.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnPetCafe.layer.backgroundColor = UIColor.white.cgColor
        btnPetCafe.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        
        cafeType = 1
    }
    
    @IBAction func btnSentimentalCafeClicked(_ sender: UIButton) {
        btnSentimentalCafe.layer.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        btnSentimentalCafe.setTitleColor(.white, for: .normal)
        btnThemeCafe.layer.backgroundColor = UIColor.white.cgColor
        btnThemeCafe.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnBrunch.layer.backgroundColor = UIColor.white.cgColor
        btnBrunch.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnPetCafe.layer.backgroundColor = UIColor.white.cgColor
        btnPetCafe.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        
        cafeType = 2
    }
    
    @IBAction func btnBrunchCafeClicked(_ sender: UIButton) {
        btnBrunch.layer.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        btnBrunch.setTitleColor(.white, for: .normal)
        btnThemeCafe.layer.backgroundColor = UIColor.white.cgColor
        btnThemeCafe.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnSentimentalCafe.layer.backgroundColor = UIColor.white.cgColor
        btnSentimentalCafe.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnPetCafe.layer.backgroundColor = UIColor.white.cgColor
        btnPetCafe.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        
        cafeType = 3
    }
    
    @IBAction func btnPetCafeClicked(_ sender: UIButton) {
        btnPetCafe.layer.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        btnPetCafe.setTitleColor(.white, for: .normal)
        btnThemeCafe.layer.backgroundColor = UIColor.white.cgColor
        btnThemeCafe.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnSentimentalCafe.layer.backgroundColor = UIColor.white.cgColor
        btnSentimentalCafe.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnBrunch.layer.backgroundColor = UIColor.white.cgColor
        btnBrunch.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        
        cafeType = 4
    }
    
    @IBAction func btnKoreanAlcholClicked(_ sender: UIButton) {
        btnKoreanAlcohol.layer.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        btnKoreanAlcohol.setTitleColor(.white, for: .normal)
        btnChineseAlcohol.layer.backgroundColor = UIColor.white.cgColor
        btnChineseAlcohol.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnJapaneseAlcohol.layer.backgroundColor = UIColor.white.cgColor
        btnJapaneseAlcohol.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnModernBar.layer.backgroundColor = UIColor.white.cgColor
        btnModernBar.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnWine.layer.backgroundColor = UIColor.white.cgColor
        btnWine.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnStreetAlcohol.layer.backgroundColor = UIColor.white.cgColor
        btnStreetAlcohol.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        
        alcoholType = 1
    }
    
    @IBAction func btnChineseAlcholClicked(_ sender: UIButton) {
        btnChineseAlcohol.layer.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        btnChineseAlcohol.setTitleColor(.white, for: .normal)
        btnKoreanAlcohol.layer.backgroundColor = UIColor.white.cgColor
        btnKoreanAlcohol.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnJapaneseAlcohol.layer.backgroundColor = UIColor.white.cgColor
        btnJapaneseAlcohol.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnModernBar.layer.backgroundColor = UIColor.white.cgColor
        btnModernBar.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnWine.layer.backgroundColor = UIColor.white.cgColor
        btnWine.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnStreetAlcohol.layer.backgroundColor = UIColor.white.cgColor
        btnStreetAlcohol.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        
        alcoholType = 2
    }
    @IBAction func btnJapaneseAlcholClicked(_ sender: UIButton) {
        btnJapaneseAlcohol.layer.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        btnJapaneseAlcohol.setTitleColor(.white, for: .normal)
        btnChineseAlcohol.layer.backgroundColor = UIColor.white.cgColor
        btnChineseAlcohol.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnKoreanAlcohol.layer.backgroundColor = UIColor.white.cgColor
        btnKoreanAlcohol.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnModernBar.layer.backgroundColor = UIColor.white.cgColor
        btnModernBar.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnWine.layer.backgroundColor = UIColor.white.cgColor
        btnWine.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnStreetAlcohol.layer.backgroundColor = UIColor.white.cgColor
        btnStreetAlcohol.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        
        alcoholType = 3
    }
    
    @IBAction func btnModernBarClicked(_ sender: UIButton) {
        btnModernBar.layer.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        btnModernBar.setTitleColor(.white, for: .normal)
        btnChineseAlcohol.layer.backgroundColor = UIColor.white.cgColor
        btnChineseAlcohol.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnJapaneseAlcohol.layer.backgroundColor = UIColor.white.cgColor
        btnJapaneseAlcohol.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnKoreanAlcohol.layer.backgroundColor = UIColor.white.cgColor
        btnKoreanAlcohol.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnWine.layer.backgroundColor = UIColor.white.cgColor
        btnWine.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnStreetAlcohol.layer.backgroundColor = UIColor.white.cgColor
        btnStreetAlcohol.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        
        alcoholType = 4
    }
    
    @IBAction func bthWineClicked(_ sender: UIButton) {
        btnWine.layer.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        btnWine.setTitleColor(.white, for: .normal)
        btnChineseAlcohol.layer.backgroundColor = UIColor.white.cgColor
        btnChineseAlcohol.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnJapaneseAlcohol.layer.backgroundColor = UIColor.white.cgColor
        btnJapaneseAlcohol.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnModernBar.layer.backgroundColor = UIColor.white.cgColor
        btnModernBar.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnKoreanAlcohol.layer.backgroundColor = UIColor.white.cgColor
        btnKoreanAlcohol.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnStreetAlcohol.layer.backgroundColor = UIColor.white.cgColor
        btnStreetAlcohol.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        
        alcoholType = 5
    }
    
    @IBAction func btnStreetAlcholClicked(_ sender: UIButton) {
        btnStreetAlcohol.layer.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        btnStreetAlcohol.setTitleColor(.white, for: .normal)
        btnChineseAlcohol.layer.backgroundColor = UIColor.white.cgColor
        btnChineseAlcohol.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnJapaneseAlcohol.layer.backgroundColor = UIColor.white.cgColor
        btnJapaneseAlcohol.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnModernBar.layer.backgroundColor = UIColor.white.cgColor
        btnModernBar.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnWine.layer.backgroundColor = UIColor.white.cgColor
        btnWine.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnKoreanAlcohol.layer.backgroundColor = UIColor.white.cgColor
        btnKoreanAlcohol.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        
        alcoholType = 6
    }
    
    @IBAction func btnPlaceRecommendClicked(_ sender: UIButton) {
        btnPlaceRecommend.layer.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        btnPlaceRecommend.setTitleColor(.white, for: .normal)
        btnPlaceNonRecommend.layer.backgroundColor = UIColor.white.cgColor
        btnPlaceNonRecommend.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        
        placeRecommendState = 1
    }
    
    @IBAction func btnPlaceNonRecommendClicked(_ sender: UIButton) {
        btnPlaceNonRecommend.layer.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        btnPlaceNonRecommend.setTitleColor(.white, for: .normal)
        btnPlaceRecommend.layer.backgroundColor = UIColor.white.cgColor
        btnPlaceRecommend.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        
        placeRecommendState = 2
    }
    
    @IBAction func btnRecommendClicked(_ sender: UIButton) {
        btnRecommend.layer.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        btnRecommend.setTitleColor(.white, for: .normal)
        btnNonRecommend.layer.backgroundColor = UIColor.white.cgColor
        btnNonRecommend.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        
        recommendState = 1
    }
    @IBAction func btnNonRecommendClicked(_ sender: UIButton) {
        btnNonRecommend.layer.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        btnNonRecommend.setTitleColor(.white, for: .normal)
        btnRecommend.layer.backgroundColor = UIColor.white.cgColor
        btnRecommend.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        
        recommendState = 2
    }
    
    @IBAction func btnAloneClicked(_ sender: UIButton) {
        if (btnAloneState == 0){
            btnAlone.layer.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0).cgColor
            btnAlone.setTitleColor(.white, for: .normal)
            btnAloneState = 1
        }else if (btnAloneState == 1) {
           btnAlone.layer.backgroundColor = UIColor.white.cgColor
           btnAlone.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
           btnAloneState = 0
        }
        companyType = 1
    }
    
    @IBAction func btnFreindClicked(_ sender: UIButton) {
        if (btnFriendState == 0){
            btnFriend.layer.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0).cgColor
            btnFriend.setTitleColor(.white, for: .normal)
            btnFriendState = 1
        }else if (btnFriendState == 1) {
            btnFriend.layer.backgroundColor = UIColor.white.cgColor
            btnFriend.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
            btnFriendState = 0
        }
        companyType = 2
    }
    
    @IBAction func btnCoupleClicked(_ sender: UIButton) {
        if (btnCoupleState == 0) {
            btnCouple.layer.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0).cgColor
            btnCouple.setTitleColor(.white, for: .normal)
            btnCoupleState = 1
        }else if (btnCoupleState == 1) {
            btnCouple.layer.backgroundColor = UIColor.white.cgColor
            btnCouple.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
            btnCoupleState = 0
        }
        companyType = 3
    }
    
    @IBAction func btnDiningTogether(_ sender: UIButton) {
        if (btnDiningTogetherState == 0) {
            btnDiningTogether.layer.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0).cgColor
            btnDiningTogether.setTitleColor(.white, for: .normal)
            btnDiningTogetherState = 1
        }else if (btnDiningTogetherState == 1) {
            btnDiningTogether.layer.backgroundColor = UIColor.white.cgColor
            btnDiningTogether.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
            btnDiningTogetherState = 0
        }
        companyType = 4
    }
    
    @IBAction func btnBusinessClicked(_ sender: UIButton) {
        if (btnBusinessState == 0) {
            btnBusiness.layer.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0).cgColor
            btnBusiness.setTitleColor(.white, for: .normal)
            btnBusinessState = 1
        }else if (btnBusinessState == 1) {
            btnBusiness.layer.backgroundColor = UIColor.white.cgColor
            btnBusiness.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
            btnBusinessState = 0
        }
        companyType = 5
    }
    
    @IBAction func btnFamilyClicked(_ sender: UIButton) {
        if (btnFamilyState == 0) {
            btnFamily.layer.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0).cgColor
            btnFamily.setTitleColor(.white, for: .normal)
            btnFamilyState = 1
        }else if (btnFamilyState == 1) {
            btnFamily.layer.backgroundColor = UIColor.white.cgColor
            btnFamily.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
            btnFamilyState = 0
        }
        companyType = 6
    }
    
    @IBAction func btnPlaceAloneClicked(_ sender: UIButton) {
        if (btnPlaceAloneState == 0) {
            btnPlaceAlone.layer.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0).cgColor
            btnPlaceAlone.setTitleColor(.white, for: .normal)
            btnPlaceAloneState = 1
        }else if (btnPlaceAloneState == 1) {
            btnPlaceAlone.layer.backgroundColor = UIColor.white.cgColor
            btnPlaceAlone.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
            btnPlaceAloneState = 0
        }
        placeCompanyType = 1
    }
    
    @IBAction func btnPlaceFriendClicked(_ sender: UIButton) {
        if (btnPlaceFriendState == 0) {
            btnPlaceFriend.layer.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0).cgColor
            btnPlaceFriend.setTitleColor(.white, for: .normal)
            btnPlaceFriendState = 1
        }else if (btnPlaceFriendState == 1) {
            btnPlaceFriend.layer.backgroundColor = UIColor.white.cgColor
            btnPlaceFriend.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
            btnPlaceFriendState = 0
        }
        placeCompanyType = 2
    }
    
    @IBAction func btnPlaceCoupleClicked(_ sender: UIButton) {
        if (btnPlaceCoupleState == 0) {
            btnPlaceCouple.layer.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0).cgColor
            btnPlaceCouple.setTitleColor(.white, for: .normal)
            btnPlaceCoupleState = 1
        }else if (btnPlaceCoupleState == 1) {
            btnPlaceCouple.layer.backgroundColor = UIColor.white.cgColor
            btnPlaceCouple.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
            btnPlaceCoupleState = 0
        }
        placeCompanyType = 3
    }
    
    @IBAction func btnPlaceDiningTogether(_ sender: UIButton) {
        if (btnPlaceDiningTogetherState == 0) {
            btnPlaceDiningTogether.layer.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0).cgColor
            btnPlaceDiningTogether.setTitleColor(.white, for: .normal)
            btnPlaceDiningTogetherState = 1
        }else if (btnPlaceDiningTogetherState == 1) {
            btnPlaceDiningTogether.layer.backgroundColor = UIColor.white.cgColor
            btnPlaceDiningTogether.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
            btnPlaceDiningTogetherState = 0
        }
        placeCompanyType = 4
    }
    
    @IBAction func btnPlaceBusinessClicked(_ sender: UIButton) {
        if (btnPlaceBusinessState == 0) {
            btnPlaceBusiness.layer.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0).cgColor
            btnPlaceBusiness.setTitleColor(.white, for: .normal)
            btnPlaceBusinessState = 1
        }else if (btnPlaceBusinessState == 1) {
            btnPlaceBusiness.layer.backgroundColor = UIColor.white.cgColor
            btnPlaceBusiness.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
            btnPlaceBusinessState = 0
        }
        placeCompanyType = 5
    }
    
    @IBAction func btnPlaceFamilyClicked(_ sender: UIButton) {
        if (btnPlaceFamilyState == 0) {
            btnPlaceFamily.layer.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0).cgColor
            btnPlaceFamily.setTitleColor(.white, for: .normal)
            btnPlaceFamilyState = 1
        }else if (btnPlaceFamilyState == 1) {
            btnPlaceFamily.layer.backgroundColor = UIColor.white.cgColor
            btnPlaceFamily.setTitleColor(.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), for: .normal)
            btnPlaceFamilyState = 0
        }
        placeCompanyType = 6
    }
    
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        let currentValue = Int(sliderPrice.value)
        price = currentValue
        if currentValue == 1 {
            lbPrice.text = "1만원 이상"
        }else if currentValue == 2 {
            lbPrice.text = "3만원 이상"
        }else if currentValue == 3 {
            lbPrice.text = "5만원 이상"
        }else if currentValue == 4 {
            lbPrice.text = "7만원 이상"
        }else if currentValue == 5 {
            lbPrice.text = "10만원 이상"
        }
    }
    
    @IBAction func addImg(_ sender: UIButton) {
        let vc = BSImagePickerViewController()
        //display picture gallery
        self.bs_presentImagePickerController(vc, animated: false, select: { (asset: PHAsset) -> Void in
        }, deselect: { (asset: PHAsset) -> Void in
            // User deselected an assets.
        }, cancel: { (assets: [PHAsset]) -> Void in
            // User cancelled. And this where the assets currently selected.
        }, finish: { (assets: [PHAsset]) -> Void in
            // User finished with these assets
            for i in 0..<assets.count {
                print("---> assets.count : \(assets.count)")
                print("---> assets[\(i)] : \(assets[i])")
                self.SelectedAssets.append(assets[i])
            }
            self.convertAssetToImages()
        }, completion: nil)
    }

    
    
    func convertAssetToImages() -> Void {
        if SelectedAssets.count != 0{
            for i in 0..<SelectedAssets.count{
                let manager = PHImageManager.default()
                let option = PHImageRequestOptions()
                var thumbnail = UIImage()
                option.isSynchronous = true
                
                manager.requestImage(for: SelectedAssets[i], targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFill, options: option, resultHandler: {(result, info)->Void in
                    thumbnail = result!
                })
                guard let data = thumbnail.jpegData(compressionQuality: 0.50) else {
                    return
                }
                let newImage = UIImage(data: data)
                self.PhotoArray.append(newImage! as UIImage)
            }
            self.imgView.animationImages = self.PhotoArray
            self.imgView.animationDuration = 3.0
            self.imgView.startAnimating()
        }
        print("complete photo array \(self.PhotoArray)")
    }

    @IBAction func btnSave(_ sender: UIButton) {
        var imgData = Array<Data>()
        for imgCount in 0...(PhotoArray.count-1){
            imgData.append(PhotoArray[imgCount].jpegData(compressionQuality: 0.7)!)
       }
        if (btnAloneState == 1) {
            companyString += "1,"
        }
        
        if (btnFriendState == 1) {
            companyString += "2,"
        }
        
        if (btnCoupleState == 1) {
            companyString += "3,"
        }
        
        if (btnDiningTogetherState == 1) {
            companyString += "4,"
        }
        
        if (btnBusinessState == 1) {
            companyString += "5,"
        }
        
        if (btnFamilyState == 1) {
            companyString += "6,"
        }
        
        if (btnPlaceAloneState == 1) {
            placeCompanyString += "1,"
        }
        
        if (btnPlaceFriendState == 1) {
            placeCompanyString += "2,"
        }
        
        if (btnPlaceCoupleState == 1) {
            placeCompanyString += "3,"
        }
        
        if (btnPlaceDiningTogetherState == 1) {
            placeCompanyString += "4,"
        }
        
        if (btnPlaceBusinessState == 1) {
            placeCompanyString += "5,"
        }
        
        if (btnPlaceFamilyState == 1) {
            placeCompanyString += "6,"
        }
        
        if (companyString.last == ",") {
            companyString = companyString.substring(to: companyString.index(before: companyString.endIndex))
            print("---> companyString : \(companyString)")
        }
        
        if (placeCompanyString.last == ",") {
            placeCompanyString = placeCompanyString.substring(to: placeCompanyString.index(before: placeCompanyString.endIndex))
            print("---> placeCompanyString : \(placeCompanyString)")
        }

        if saveType == 1 {
            let parameters = ["name": name , "address" : address, "latitude" : String(latitude), "longtitude" : String(longitude), "saveType" : String(saveType), "foodType" : String(foodType), "recommendState" : String(recommendState), "companyType" : String(companyType), "price" : String(price), "menu" : txtMenu.text!, "tag" : txtTag.text!, "SEQ_User" : String(UserDefaults.standard.integer(forKey: "SEQ_User")), "id" : id, "companyString" : companyString]
            Alamofire.upload(multipartFormData: { multipartFormData in
                for count in 0...(imgData.count-1) {
                    multipartFormData.append(imgData[count], withName: "fileset",fileName: "file\(count).jpg", mimeType: "image/jpg")
                }
                for (key, value) in parameters {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
            }, to:"http://112.149.7.38:8090/Final_Minimap/SavePost")
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
        }else if saveType == 2 {
            let parameters = ["name": name , "address" : address, "latitude" : String(latitude), "longtitude" : String(longitude), "saveType" : String(saveType), "cafeType" : String(cafeType), "recommendState" : String(recommendState), "companyType" : String(companyType), "price" : String(price), "menu" : txtMenu.text!, "tag" : txtTag.text!, "SEQ_User" : String(UserDefaults.standard.integer(forKey: "SEQ_User")), "id" : id, "companyString" : companyString]
            Alamofire.upload(multipartFormData: { multipartFormData in
                for count in 0...(imgData.count-1) {
                    multipartFormData.append(imgData[count], withName: "fileset",fileName: "file\(count).jpg", mimeType: "image/jpg")
                }
                for (key, value) in parameters {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
            }, to:"http://112.149.7.38:8090/Final_Minimap/SavePost")
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
        }else if saveType == 3 {
            let parameters = ["name": name , "address" : address, "latitude" : String(latitude), "longtitude" : String(longitude), "saveType" : String(saveType), "alcoholType" : String(alcoholType), "recommendState" : String(recommendState), "companyType" : String(companyType), "price" : String(price), "menu" : txtMenu.text!, "tag" : txtTag.text!, "SEQ_User" : String(UserDefaults.standard.integer(forKey: "SEQ_User")), "id" : id, "companyString" : companyString]
            Alamofire.upload(multipartFormData: { multipartFormData in
                for count in 0...(imgData.count-1) {
                    multipartFormData.append(imgData[count], withName: "fileset",fileName: "file\(count).jpg", mimeType: "image/jpg")
                }
                for (key, value) in parameters {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
            }, to:"http://112.149.7.38:8090/Final_Minimap/SavePost")
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
        }else if saveType == 4 {
            let parameters = ["name": name , "address" : address, "latitude" : String(latitude), "longtitude" : String(longitude), "saveType" : String(saveType), "recommendState" : String(placeRecommendState), "companyType" : String(placeCompanyType), "tag" : txtPlaceTag.text!, "SEQ_User" : String(UserDefaults.standard.integer(forKey: "SEQ_User")), "id" : id, "companyString" : placeCompanyString]
            Alamofire.upload(multipartFormData: { multipartFormData in
                for count in 0...(imgData.count-1) {
                    multipartFormData.append(imgData[count], withName: "fileset",fileName: "file\(count).jpg", mimeType: "image/jpg")
                }
                for (key, value) in parameters {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
            }, to:"http://112.149.7.38:8090/Final_Minimap/SavePost")
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
        }else if saveType == 5 {
            let parameters = ["name": name , "address" : address, "latitude" : String(latitude), "longtitude" : String(longitude), "saveType" : String(saveType), "tag" : txtSaveTag.text!, "SEQ_User" : String(UserDefaults.standard.integer(forKey: "SEQ_User")), "id" : id]
            Alamofire.upload(multipartFormData: { multipartFormData in
                for count in 0...(imgData.count-1) {
                    multipartFormData.append(imgData[count], withName: "fileset",fileName: "file\(count).jpg", mimeType: "image/jpg")
                }
                for (key, value) in parameters {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
            }, to:"http://112.149.7.38:8090/Final_Minimap/SavePost")
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

        print("---- 저장 ----")
        if saveType == 1 {
            print("saveType : \(saveType), 음식")
            if foodType == 1 {
                print("foodType : \(foodType), 한식")
            }else if foodType == 2 {
                print("foodType : \(foodType), 중식")
            }else if foodType == 3 {
                print("foodType : \(foodType), 일식")
            }else if foodType == 4 {
                print("foodType : \(foodType), 양식")
            }else if foodType == 5 {
                print("foodType : \(foodType), 동남아")
            }else if foodType == 6 {
                print("foodType : \(foodType), 야식")
            }else if foodType == 7 {
                print("foodType : \(foodType), 분식")
            }
            if companyType == 1 {
                print("companyType : \(companyType), 혼자")
            }else if companyType == 2 {
                print("companyType : \(companyType), 친구")
            }else if companyType == 3 {
                print("companyType : \(companyType), 연인")
            }else if companyType == 4 {
                print("companyType : \(companyType), 회식")
            }else if companyType == 5 {
                print("companyType : \(companyType), 비지니스")
            }else if companyType == 6 {
                print("companyType : \(companyType), 가족")
            }
            if recommendState == 1 {
                print("긍정")
            }else if recommendState == 2 {
                print("부정")
            }
        }else if saveType == 2 {
            print("saveType : \(saveType), 카페")
            if cafeType == 1 {
                print("cafeType : \(cafeType), 테마")
            }else if cafeType == 2 {
               print("cafeType : \(cafeType), 감성")
            }else if cafeType == 3 {
                print("cafeType : \(cafeType), 브런치")
            }else if cafeType == 4 {
                print("cafeType : \(cafeType), 애견")
            }
            if companyType == 1 {
                print("companyType : \(companyType), 혼자")
            }else if companyType == 2 {
                print("companyType : \(companyType), 친구")
            }else if companyType == 3 {
                print("companyType : \(companyType), 연인")
            }else if companyType == 4 {
                print("companyType : \(companyType), 회식")
            }else if companyType == 5 {
                print("companyType : \(companyType), 비지니스")
            }else if companyType == 6 {
                print("companyType : \(companyType), 가족")
            }
            if recommendState == 1 {
                print("긍정")
            }else if recommendState == 2 {
                print("부정")
            }
        }else if saveType == 3 {
            print("saveType : \(saveType), 술")
            if alcoholType == 1 {
                print("cafeType : \(alcoholType), 한식")
            }else if alcoholType == 2 {
                print("cafeType : \(alcoholType), 중식")
            }else if alcoholType == 3 {
                print("cafeType : \(alcoholType), 일식")
            }else if alcoholType == 4 {
                print("cafeType : \(alcoholType), 모던 바")
            }else if alcoholType == 5 {
                print("cafeType : \(alcoholType), 와인")
            }else if alcoholType == 6 {
                print("cafeType : \(alcoholType), 포차")
            }
            if companyType == 1 {
                print("companyType : \(companyType), 혼자")
            }else if companyType == 2 {
                print("companyType : \(companyType), 친구")
            }else if companyType == 3 {
                print("companyType : \(companyType), 연인")
            }else if companyType == 4 {
                print("companyType : \(companyType), 회식")
            }else if companyType == 5 {
                print("companyType : \(companyType), 비지니스")
            }else if companyType == 6 {
                print("companyType : \(companyType), 가족")
            }
            if recommendState == 1 {
                print("긍정")
            }else if recommendState == 2 {
                print("부정")
            }
        }else if saveType == 4 {
            print("saveType : \(saveType), 장소")
            if placeRecommendState == 1 {
                print("긍정")
            }else if placeRecommendState == 2 {
                print("부정")
            }
            if placeCompanyType == 1 {
                print("companyType : \(placeCompanyType), 혼자")
            }else if placeCompanyType == 2 {
                print("companyType : \(placeCompanyType), 친구")
            }else if placeCompanyType == 3 {
                print("companyType : \(placeCompanyType), 연인")
            }else if placeCompanyType == 4 {
                print("companyType : \(placeCompanyType), 회식")
            }else if placeCompanyType == 5 {
                print("companyType : \(placeCompanyType), 비지니스")
            }else if placeCompanyType == 6 {
                print("companyType : \(placeCompanyType), 가족")
            }
        }else if saveType == 5 {
            print("saveType : \(saveType), 저장")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "goFeed" {
            if let vc = segue.destination as? MyFeedViewController {
                vc.SEQ_Owner = UserDefaults.standard.integer(forKey: "SEQ_User")
            }
        }
    }
}

extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}


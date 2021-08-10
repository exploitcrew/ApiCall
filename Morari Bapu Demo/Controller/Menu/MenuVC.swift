//
//  MenuVC.swift
//  Morari Bapu Demo
//
//  Created by Akshay chauhan on 23/06/21.
//  Copyright © 2021 Akshay chauhan. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire



class MenuVC: UIViewController {
    
      @IBOutlet var cvMenu: UICollectionView!
    
    var arrMenu  = [String:JSON]()

    var arrMenuList = ["Home","Katha Copai"]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let param = ["app_id" : "Device_id"] as NSDictionary
        var req = URLRequest(url: try! "http://app.nivida.in/moraribapu/Kathavideo/App_GetDailyKathavideo" .asURL())
        
        req.httpMethod = "POST"
        req.allHTTPHeaderFields = [:]
        req.setValue("application/json", forHTTPHeaderField: "content-type")
        req.httpBody = try! JSONSerialization.data(withJSONObject: param)
        req.timeoutInterval = 30
        
        Alamofire.request(req).responseJSON { [self] response in
            
            switch (response.result)
            {
            case .success:
                
                if((response.result.value) != nil) {
                    let jsonResponce = JSON(response.result.value!)
                    
                    //if APP_MODE == "Development"{
                    print("Responce: \n\(jsonResponce)")
                    //}
                   if jsonResponce["status"].boolValue == true{
                        self.arrMenu = jsonResponce["data"].dictionaryValue
                        if self.arrMenu.count != 0 { //cgecking for array count
                            self.cvMenu.reloadData() //data hoi to tbl reload
                      }
                   }
                }
                break
            case .failure(let error):
                
                let message : String
                
                if let httpStatusCode = response.response?.statusCode {
                    switch(httpStatusCode) {
                    case 400:
                        message = "Username or password not provided"
                    case 401:
                        message = "The email/password is invalid"
                    default: break
                    }
                } else {
                    message = error.localizedDescription
                    let jsonError = JSON(response.result.error!)
                }
                break
            }
        }
    }
}


    





extension MenuVC: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrMenuList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCollectionViewCell", for: indexPath) as! MenuCollectionViewCell
        
         cell.imgMenu.image = UIImage(named: "menu_\(indexPath.row+1)")
        
        
        cell.lblNumber.layer.masksToBounds = true
        cell.lblNumber.layer.borderWidth = 1.5
        cell.lblNumber.layer.borderColor = UIColor.white.cgColor
        cell.lblNumber.layer.cornerRadius = cell.lblNumber.frame.height / 2
        cell.lblTitle.text = arrMenuList[indexPath.row]
        
        cell.lblNumber.isHidden = true
        
        return cell
   }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {let vc = storyboard?.instantiateViewController(withIdentifier: "DashboardVC") as? DashboardVC
            self.navigationController?.pushViewController(vc!, animated: true)
        }else if indexPath.row == 1 {let vc = storyboard?.instantiateViewController(withIdentifier: "KathaChopaiVC") as? KathaChopaiVC
            self.navigationController?.pushViewController(vc!, animated: true)
            
        }
}
    
  
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if UIDevice.current.userInterfaceIdiom == .pad{
            let yourWidth = (collectionView.bounds.width - 40) / 3.0
            let yourHeight = yourWidth
            
            return CGSize(width: yourWidth, height: yourHeight - 15)
        }
        else{
            let yourWidth = (collectionView.bounds.width - 40) / 3.0
            let yourHeight = yourWidth
            
            return CGSize(width: yourWidth, height: yourHeight - 15)

        }
    }
    
}




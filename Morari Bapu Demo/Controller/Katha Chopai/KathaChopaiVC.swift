//
//  KathaChopaiVC.swift
//  Morari Bapu Demo
//
//  Created by Akshay chauhan on 21/06/21.
//  Copyright © 2021 Akshay chauhan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class KathaChopaiVC: UIViewController {

    @IBOutlet weak var tblKathaChopai: UITableView!
    @IBOutlet weak var lblTitle: UILabel!
    
    var arrKhataChopai = [JSON]()
    var arrFavourite = NSMutableArray()
    
    var currentPageNo = Int()
    var totalPageNo = Int()
    var is_Api_Being_Called : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblKathaChopai.tableFooterView =  UIView.init(frame: .zero)
        tblKathaChopai.layoutMargins = .zero
        
        tblKathaChopai.rowHeight = 150
        tblKathaChopai.estimatedRowHeight = UITableView.automaticDimension
        
        currentPageNo = 1
        
        
        
        lblTitle.text = "Katha Chopai"
//        self.arrKhataChopai.removeAll()
//        self.arrFavourite.removeAllObjects()
        getKathaChopai(pageNo: currentPageNo)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        
    }
        
        func getKathaChopai(pageNo:Int){
        
        let param = ["page" : pageNo,
                     "app_id":Utility.getDeviceID(),
                     "favourite_for":"2"] as NSDictionary
        
        var req = URLRequest(url: try! "http://app.nivida.in/moraribapu/KathaChopai/App_GetKathaChopai" .asURL())
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
                    print("Responce: \n\(jsonResponce)")
                    if jsonResponce["status"].boolValue == true{
                        
                        for result in jsonResponce["data"].arrayValue{
                            self.arrKhataChopai.append(result)
                        }
                        for result in jsonResponce["MyFavourite"].arrayValue{
                            self.arrFavourite.add(result.stringValue)
                        }
                        
                        self.totalPageNo = jsonResponce["total_page"].intValue
                        
                        self.is_Api_Being_Called = false
                        
                       
                        if self.arrKhataChopai.count != 0 { //cgecking for array count
                            self.tblKathaChopai.reloadData() //data hoi to tbl reload
                        }
                        print(self.arrKhataChopai[1]["quotes_hindi"].stringValue)
                    }else{
                        //Faliure
                        print("\(jsonResponce["message"].stringValue)")
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
                        // print("!Error status code: %d",httpStatusCode)
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
    //MARK : Button Event
    
    @IBAction func backToHome(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated:true)
    }
    
}



extension KathaChopaiVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrKhataChopai.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: KathaChopaiTableViewCell = self.tblKathaChopai.dequeueReusableCell(withIdentifier: "KathaChopaiTableViewCell") as! KathaChopaiTableViewCell
        
        let dictKatha = arrKhataChopai[indexPath.row]
        
        
        
        cell.lblTitle.text = "\(dictKatha["title"].stringValue) - \(dictKatha["title_no"].stringValue)"
        cell.lblDescription1.text = dictKatha["katha_hindi"].stringValue
        cell.lblTitle.text = "\(dictKatha["title"].stringValue) - \(dictKatha["title_no"].stringValue)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "KathaChopaiDetailsVC") as? KathaChopaiDetailsVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    // mark :- pagination
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == arrKhataChopai.count - 1{
            if is_Api_Being_Called == false{
                if currentPageNo <  totalPageNo{
                    print("Page Load....")
                    is_Api_Being_Called = true
                    currentPageNo += 1
                    print(is_Api_Being_Called)
                    print(currentPageNo)
                    print(arrKhataChopai.count)
                    self.getKathaChopai(pageNo: currentPageNo)
                }
//                self.perform(#selector(loadTable), with: nil, afterDelay: 1.0)
            }
        }
    }
//    @objc func loadTable() {
//        self.tblKathaChopai.reloadData()
//    }
    
}

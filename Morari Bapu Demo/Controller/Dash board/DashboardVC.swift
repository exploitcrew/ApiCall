//
//  DashboardVC.swift
//  Morari Bapu Demo
//
//  Created by Akshay chauhan on 22/06/21.
//  Copyright © 2021 Akshay chauhan. All rights reserved.
//


import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import iCarousel


class DashboardVC: UIViewController {
    
    
    @IBOutlet weak var lblSliderTitle: UILabel!
    @IBOutlet weak var vwCarousel: iCarousel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var carouselHeight: NSLayoutConstraint!
    @IBOutlet weak var imgViewMain: UIImageView!
    
    
    
    
    
    
    let screenSize: CGRect = UIScreen.main.bounds
    
    var arrSlider  = [JSON]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        let param = ["app_id" : "Device_id",
                     "page" : "12" ] as NSDictionary
        
        var req = URLRequest(url: try! "http://app.nivida.in/moraribapu/Slider/App_Get_Slider" .asURL())
        
        //Slider/App_Get_Slider
        
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
                        //Success
                        
                        //self.arrQuotes.count
                        
                        self.arrSlider = jsonResponce["data"].arrayValue
                        
                        self.pageControl.numberOfPages = self.arrSlider.count
//
                        DispatchQueue.main.async {
                            self.vwCarousel.type = iCarouselType.linear
                            self.vwCarousel.scrollToItem(at: 0, animated: true)

                            self.vwCarousel.isScrollEnabled = true


                            self.vwCarousel.autoscroll = -0.3;
                            self.vwCarousel.scrollSpeed = 0.3
                            self.vwCarousel.decelerationRate = 0.3



                            self.vwCarousel.reloadData()
                            self.view.layoutIfNeeded()
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
    
   
    
    @IBAction func btnMenu(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "MenuVC") as! MenuVC
//        self.present(vc, animated: true)
     Utility.menu_Show(onViewController: self)
        
        
}
    @IBAction func btnHanumanChalisha(_ sender: Any) {
}
    
    
    
    

}



extension DashboardVC : iCarouselDataSource, iCarouselDelegate{
    func numberOfItems(in carousel: iCarousel) -> Int {
        return arrSlider.count
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        
        
        switch (option) {
        case .spacing: return 1.34 // 8 points spacing
        case .wrap:return 1;
        default: return value
        }
        
        
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var itemView: UIImageView
        if (view == nil)
        {
            let screenWidth = screenSize.width * 0.70
            
            let screenHeight = screenSize.height
            
            itemView = UIImageView(frame:CGRect(x:0, y:0, width:screenWidth, height:screenHeight - 160))
            itemView.contentMode = .scaleAspectFit
        }
        else
        {
            itemView = view as! UIImageView;
        }
        
        let image = arrSlider[index]
        
        let placeHolder = UIImage(named: "youtube_placeholder")
        let imageStr = "\("http://app.nivida.in/moraribapu/files/")\(image["image"].stringValue)"
        let imageString = imageStr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        
        itemView.kf.setImage(with: URL(string: imageString!), placeholder: placeHolder, options: [.transition(ImageTransition.fade(1))])
        
        return itemView
    }
    
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        
        if arrSlider.count != 0{
            
            
            let image = arrSlider[carousel.currentItemIndex]
            
            let placeHolder = UIImage(named: "youtube_placeholder")
            let imageStr = "\("http://app.nivida.in/moraribapu/files/")\(image["image"].stringValue)"
            let imageString = imageStr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            
            self.imgViewMain.kf.setImage(with: URL(string: imageString!), placeholder: placeHolder, options: [.transition(ImageTransition.fade(1))])
            
            self.pageControl.currentPage = carousel.currentItemIndex
        }
        
        
    }
    
    private func carousel(carousel: iCarousel, didSelectItemAtIndex index: Int)
    {
        print(index)
    }
    
    
}


//
//  KathaChopaiDetailsVC.swift
//  Morari Bapu Demo
//
//  Created by Akshay chauhan on 21/06/21.
//  Copyright © 2021 Akshay chauhan. All rights reserved.
//

import UIKit
import SwiftyJSON

class KathaChopaiDetailsVC: UIViewController {
    
    
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var btnFavourite: UIButton!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDescription1: UILabel!
    @IBOutlet weak var lblDescription2: UILabel!
    @IBOutlet weak var lblDescription3: UILabel!
    @IBOutlet weak var lblDescription4: UILabel!
    
    var arrKathaDetails = [String:JSON]()
    

    override func viewDidLoad() {
        
        super.viewDidLoad()

        
    }
    
    //MARK : Button Event
    
    @IBAction func backToHome(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated:true)
    }

}

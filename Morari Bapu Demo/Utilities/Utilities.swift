//
//  Utilities.swift
//  Morari Bapu Demo
//
//  Created by Akshay chauhan on 25/06/21.
//  Copyright © 2021 Akshay chauhan. All rights reserved.
//

import Foundation
import UIKit

class Utility: NSObject {

    //MARK:- DropDown (Show Hide)
    static func menu_Show(onViewController: UIViewController) {
        DispatchQueue.main.async {
            let storyboardCustom : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let objVC = storyboardCustom.instantiateViewController(withIdentifier: "MenuVC") as? MenuVC
            objVC?.modalPresentationStyle = .overCurrentContext
            objVC?.modalTransitionStyle = .crossDissolve
            onViewController.present(objVC!, animated: false, completion: nil)
        }
    }
    
    
    static func getDeviceID() -> String {
        
        return UIDevice.current.identifierForVendor!.uuidString
        
    }

}


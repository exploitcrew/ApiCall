//
//  KathaChopaiTableViewCell.swift
//  Morari Bapu Demo
//
//  Created by Akshay chauhan on 21/06/21.
//  Copyright © 2021 Akshay chauhan. All rights reserved.
//

import UIKit

class KathaChopaiTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var btnFavourite: UIButton!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDescription1: UILabel!    
    @IBOutlet weak var btnTitle: UIButton!
    @IBOutlet weak var viewBackground: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}

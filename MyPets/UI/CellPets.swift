//
//  CellPets.swift
//  MyPets
//
//  Created by DuongIOS on 1/11/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import UIKit

class CellPets: UITableViewCell {

    @IBOutlet weak var img_Pet: UIImageView!
    @IBOutlet weak var lbl_NamePet: UILabel!
    @IBOutlet weak var lbl_DatePet: UILabel!
    @IBOutlet weak var lbl_KindGender: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        lbl_DatePet.textColor = UIColor.orange
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

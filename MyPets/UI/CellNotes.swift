//
//  CellNotes.swift
//  MyPets
//
//  Created by NguyenDucBien on 3/11/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import UIKit

class CellNotes: UITableViewCell {

    @IBOutlet weak var lbNamePet: UILabel!
    
    @IBOutlet weak var contentNotes: UILabel!
    
    @IBOutlet weak var lbDate: UILabel!
    
    @IBOutlet weak var lbRemind: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lbNamePet.textColor = UIColor.orange
        lbNamePet.textAlignment = .center
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}

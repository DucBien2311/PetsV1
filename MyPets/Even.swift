//
//  Even.swift
//  MyPets
//
//  Created by khacviet on 3/6/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import Foundation

class Even {
    var id_even = Int64()
    var id_pet = Int64()
    var date_even = String()
    var text_even = String()
    var image_videoPath = String()
    
    init(id_even: Int64, id_pet: Int64, date_even: String, text_even: String, image_videoPath: String) {
        self.id_even = id_even
        self.id_pet = id_pet
        self.date_even = date_even
        self.text_even = text_even
        self.image_videoPath = image_videoPath
    }
}

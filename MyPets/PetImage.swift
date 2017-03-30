//
//  PetImage.swift
//  MyPets
//
//  Created by DuongIOS on 2/4/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import Foundation

class PetImage {
    var id_image = Int64()
    var id_pet = Int64()
    var imagePath = String()
    
    init(id_image: Int64, id_pet: Int64, imagePath: String) {
        self.id_image = id_image
        self.id_pet = id_pet
        self.imagePath = imagePath
    }
}

//
//  Pet.swift
//  MyPets
//
//  Created by DuongIOS on 2/3/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import Foundation

class Pet {
    let id: Int64?
    var name: String
    var kind: String
    var gender: String
    var dateOfBirth: String
    var petAvata: String
    
    
    init(id: Int64) {
        self.id = id
        name = ""
        kind = ""
        gender = ""
        dateOfBirth = ""
        petAvata = ""

    }
    
    init(id: Int64, name: String, kind: String, gender: String, dateOfBirth: String, petAvata: String) {
        self.id = id
        self.name = name
        self.kind = kind
        self.gender = gender
        self.dateOfBirth = dateOfBirth
        self.petAvata = petAvata
    }
    
}

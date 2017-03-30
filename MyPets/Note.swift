//
//  Note.swift
//  MyPets
//
//  Created by khacviet on 3/6/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import Foundation

class Note {
    var id_note = Int64()
    var id_pet = Int64()
    var time_note = Date()
    var text_note = String()
    var remind = Bool()
    var active = Bool()
    
    init(id_note: Int64, id_pet: Int64, time_note: Date, text_note: String, remind: Bool, active: Bool) {
        self.id_note = id_note
        self.id_pet = id_pet
        self.time_note = time_note
        self.text_note = text_note
        self.remind = remind
        self.active = active
    }
}

//
//  Notification.swift
//  MyPets
//
//  Created by khacviet on 3/6/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import Foundation
class Notification
{
    var id_notif = Int64()
    var id_pet = Int64()
    var notif_body = String()
    
    init(id_notif: Int64, id_pet: Int64, notif_body: String) {
        self.id_notif = id_notif
        self.id_pet = id_pet
        self.notif_body = notif_body
    }

    var badge: Int!
    
    static let sharedInstance: Notification = {
        let instance = Notification()
        // setup code
        return instance
    }()
    init() {
        badge = 0
    }
}

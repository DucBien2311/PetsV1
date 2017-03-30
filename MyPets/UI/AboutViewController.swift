//
//  AboutViewController.swift
//  MyPets
//
//  Created by iOS Student on 3/30/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    @IBOutlet weak var avatarJun: UIImageView!
    @IBOutlet weak var avatarViet: UIImageView!
    @IBOutlet weak var btnFeedbackApp: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setAvatar()
        btnFeedbackApp.addTarget(self, action: #selector(didTapGoogleForm), for: UIControlEvents.touchUpInside)
    }

    func setAvatar() {

        avatarJun.layer.cornerRadius = 6
        avatarJun.layer.shadowRadius = 2
        avatarJun.layer.masksToBounds = true
        avatarViet.layer.cornerRadius = 6
        avatarViet.layer.shadowRadius = 2
        avatarViet.layer.masksToBounds = true
    }

    @IBAction func didTapGoogleForm(_ sender: UIButton) {
        UIApplication.shared.openURL(URL(string: "https://goo.gl/forms/Si2q4AuJl8UGcjfh1")!)
    }


}

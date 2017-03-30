//
//  BaseMyPetsViewController.swift
//  MyPets
//
//  Created by Tuuu on 1/3/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import UIKit

class BaseMyPetsNaviViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.barTintColor = UIColor(red: 0.97, green: 0.48, blue: 0.15, alpha: 1.0)
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

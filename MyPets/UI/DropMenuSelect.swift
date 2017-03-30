//
//  DropMenuSelect.swift
//  MyPets
//
//  Created by NguyenDucBien on 3/9/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import UIKit


protocol ChooseDelegate {
    func chooseGender(index: Int)
    func chooseKind(index: Int)
}

class DropdownMenu: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!
    var kind: [String] = ["Dog", "Cat", "Fish", "Bird", "Mouse", "Rabbit"]
    var gender: [String] = ["Male", "Female"]
    var delegate: ChooseDelegate?
    var genderButtonIsSelected: Bool = false
    var kindButtonIsSelected: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.addSubview(tableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if kindButtonIsSelected
        {
            return kind.count
        }
        else if genderButtonIsSelected
        {
            return gender.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        if kindButtonIsSelected
        {
            cell.textLabel?.text = self.kind[indexPath.row]
        }
        else if genderButtonIsSelected
        {
            cell.textLabel?.text = self.gender[indexPath.row]
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if kindButtonIsSelected
        {
            self.delegate?.chooseKind(index: indexPath.row)
        }
        else if genderButtonIsSelected
        {
            self.delegate?.chooseGender(index: indexPath.row)
        }
    }
    
    func selectedButton(index: Int)
    {
        if index == 1
        {
            kindButtonIsSelected = true
        }
        else if index == 2
        {
            genderButtonIsSelected = true
        }
    }    
}

//
//  CustomChooseNamePets.swift
//  MyPets
//
//  Created by NguyenDucBien on 3/9/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import UIKit

protocol ChooseNameDelegate {
    func chooseNamePets(index: Int)
}

class DropdownNamePets: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!
    var delegate: ChooseNameDelegate?
//    var name: [String] = [] //"Rocky Ngu Đần", "Rex Xấu Xí", "Bob Mập Ú"
    
    let database = DataBase.shareInstance
    fileprivate var pets = [Pet]()
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        
    }
    
    func addTableView(){
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
        
        pets = database.getPets()        
        return pets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        pets = database.getPets()
        
        cell.textLabel?.text = self.pets[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.chooseNamePets(index: indexPath.row)
    }
}

//
//  TimeLineViewController.swift
//  MyPets
//
//  Created by khacviet on 3/8/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import UIKit

class TimeLineViewController: UIViewController {
    
    @IBOutlet weak var table_TimeLine: UITableView!
    @IBOutlet weak var imagePet: UIImageView!
    @IBOutlet weak var lblNamePet: UILabel!
    
    static let shareInstance = TimeLineViewController()
    var idPetSelect: Int64 = 0
    var nCheckPets: Bool = true
    var nCheckEvens: Bool = true
    
    var nCheckLoadData: Bool = true
    
    let database = DataBase.shareInstance
    fileprivate var evens = [Even]()
    fileprivate var pets = [Pet]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.idPetSelect = TimeLineViewController.shareInstance.idPetSelect
        TimeLineViewController.shareInstance.nCheckEvens = true
        TimeLineViewController.shareInstance.nCheckLoadData = true
        
        evens = database.getEven(idPetSelect)
        evens = evens.sorted(by: ({ $0.id_even > $1.id_even }))
        
        pets = database.getPets()
        self.table_TimeLine.reloadData()
        
        petAfterChanged()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 0.91, green: 0.91, blue: 0.92, alpha: 1.0)
        lblNamePet.textColor = UIColor(red: 0.97, green: 0.48, blue: 0.15, alpha: 1.0)
        let CellTimeLine = UINib(nibName: "CellTimeLine", bundle: nil)
        table_TimeLine.register(CellTimeLine, forCellReuseIdentifier: "CellTimeLine")
        
        table_TimeLine.delegate = self
        table_TimeLine.dataSource = self
        
        pets = database.getPets()
        
        setButtonForRightBarNavi()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        setImageViewCircle(nId: Int(idPetSelect) - 1)
        
    }
    
    func setImageViewCircle(nId: Int){
        
        self.title = "\(pets[nId].name)"
        lblNamePet.text = "\(pets[nId].name)"
        imagePet.layer.cornerRadius = imagePet.frame.size.width/2
        imagePet.clipsToBounds = true
        let imageUrl = URL(fileURLWithPath: kPets + "/\(pets[nId].name)" + "/\(pets[nId].petAvata).jpeg")
        let data = try? Data(contentsOf: imageUrl)
        imagePet.image = UIImage(data: data!)
    }
    
    func setButtonForRightBarNavi() {
        let rightButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewEven))
        rightButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    func addNewEven() {
        let VC = AddEven(nibName: "AddEven", bundle: nil)
        
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func changeInfo(_ sender: UIButton) {
        let VC = AddPet(nibName: "AddPet", bundle: nil)
        TimeLineViewController.shareInstance.nCheckPets = false
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    
    func editEven() {
        let vc = AddEven(nibName: "AddEven", bundle: nil)
        
        TimeLineViewController.shareInstance.nCheckEvens = false
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func petAfterChanged() {
        let index = Int(idPetSelect) - 1
        
        lblNamePet.text = pets[index].name
        
        let imageUrl = URL(fileURLWithPath: kPets + "/\(pets[index].name)" + "/\(pets[index].petAvata).jpeg")
        let data = try? Data(contentsOf: imageUrl)
        imagePet.image = UIImage(data: data!)
        
    }
    
}

extension TimeLineViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return evens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table_TimeLine.dequeueReusableCell(withIdentifier: "CellTimeLine", for: indexPath) as! CellTimeLine
        cell.lbl_TextEven.text = evens[indexPath.row].text_even
        cell.lbl_TextEven.textAlignment = .center
        cell.lbl_Date.text = evens[indexPath.row].date_even
        let imageUrl = URL(fileURLWithPath: kTimelines + "/\(evens[indexPath.row].id_pet)" + "/\(evens[indexPath.row].image_videoPath).jpeg")
        let data = try? Data(contentsOf: imageUrl)
        cell.img_Even.image = UIImage(data: data!)
        
        cell.btnEdit.tag = Int(evens[indexPath.row].id_even)
        
//        AddEven.shareInstance.idEvenChanging = Int64(indexPath.row) + Int64(1)
        AddEven.shareInstance.idEvenChanging = evens[indexPath.row].id_even + Int64(1)
        
        cell.btnEdit.addTarget(self, action: #selector(editEven), for: .touchUpInside)
        
        return cell
    }
}

extension TimeLineViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

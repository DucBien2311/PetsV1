//
//  ViewController.swift
//  showImageWithCollectionView
//
//  Created by khacviet on 1/17/17.
//  Copyright © 2017 khacviet. All rights reserved.
//
//Viet

import UIKit
import Photos

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var imageArray = [UIImage]()
    var fileList: NSArray?
    var documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory
        , .allDomainsMask, true)[0]
    let fileManager:FileManager = FileManager.default
    var fileNames: [String] = []
    var images: Images!
    var scrollView: ViewScroll!
    var clickedImage: CGFloat!
    var urlArray: [URL] = []
    override func viewDidLoad() {
        self.title = "Photos"
        grabPhotos2()
        print(urlArray)
        
    }
    
    func grabPhotos2() {
        fileList = listFilesFromDocumentsFolder() as NSArray?
        var image: UIImage
        if (fileList?.count)! > 0 {
            for i in 0..<(fileList?.count)! {
                if fileManager.fileExists(atPath: (fileList?[i])! as! String) != true {
                    let fileURL = URL(fileURLWithPath: documentsPath + "/\((fileList?[i])!)")
//                    print(fileURL.pathExtension)
                    if fileURL.pathExtension == "jpg" || fileURL.pathExtension == "jpeg" || fileURL.pathExtension == "png" {
                        let data = try? Data(contentsOf: fileURL)
//                        print(fileURL)
                        image = UIImage(data: data!)!
                        self.imageArray.append(image)
                        var a: [String] = [fileURL.lastPathComponent]
                        fileNames = fileNames + a
                        urlArray = urlArray + [fileURL]
                        
                    }
                }
            }
        }
    }
    
    func listFilesFromDocumentsFolder() -> [String]? { // duyet folder de xem trong day co nhung file nao
        let dirs = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
        if dirs != nil {
            let dir = dirs[0]
            do {
                if let fileList = try? FileManager.default.contentsOfDirectory(atPath: dir)
                {
                    return fileList
                }
            }
            catch let e as exception {
//                print("e: \(e)")
            }
        }else {
            
//            print("bien 2 : \(fileList.count)")
            
            let fileList = [""]
            return fileList
        }
        return nil
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let imageView = cell.viewWithTag(101) as! UIImageView
        imageView.image = imageArray[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3 - 1
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        let images = Images.sharedInstance
        images.clickedImage = clickedImage
        images.cells = imageArray
    }
    
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        clickedImage = CGFloat(indexPath.row)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let scrollView = storyBoard.instantiateViewController(withIdentifier: "scrollView") as! ViewScroll
        self.present(scrollView, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

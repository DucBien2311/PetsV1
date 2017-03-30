//
//  CellTimeLine.swift
//  MyPets
//
//  Created by khacviet on 3/8/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import UIKit

class CellTimeLine: UITableViewCell {
    
    @IBOutlet weak var lbl_TextEven: UILabel!
    @IBOutlet weak var img_Even: UIImageView!
    @IBOutlet weak var lbl_Date: UILabel!
    
    @IBOutlet weak var btnEdit: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lbl_Date.textAlignment = .center
        lbl_Date.textColor = UIColor.white
        lbl_Date.font = UIFont.systemFont(ofSize: 14)
        lbl_Date.backgroundColor = UIColor(red: 0.97, green: 0.48, blue: 0.15, alpha: 1.0)
        lbl_TextEven.backgroundColor = UIColor(red: 0.91, green: 0.91, blue: 0.92, alpha: 1.0)
        
        
        //        lbl_TextEven.text = "Tỉ lệ của một hình ảnh là mối quan hệ giữa chiều rộng và chiều cao của hình ảnh đó. Để biểu diễn tỉ lệ thông thường người sử dụng hai số dương viết liền với nhau với dấu hai chấm ở giữa, chẳng hạn như 16:9. Với một hình ảnh có tỉ lệ x:y thì x được xem là chiều rộng, y là chiều cao và hai biến này có quan hệ tỉ lệ với nhau. Giả sử một hình ảnh có tỉ lệ là 4:3, nếu biết chiều rộng là 400 pixes thì có thể suy ra chiều cao là 300 pixes. Tỉ lệ của một hình ảnh thường áp dụng cho một hình ảnh, hình ảnh kỹ thuật số, kích thước màn hình tivi hay các thiết bị điện tử, khổ giấy, tranh vẽ và nhiều ứng dụng khác liên quan."
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}

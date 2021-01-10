//
//  CollectionViewCell.swift
//  Bidirectional
//
//  Created by dato on 1/10/21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var bigView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func conf(with model: Contact){
        view.clipsToBounds = true
        view.layer.cornerRadius = view.frame.size.width/2
        bigView.layer.borderWidth = 0.5
        bigView.layer.borderColor = UIColor.black.cgColor
        bigView.layer.cornerRadius = 10
        
        self.name.text = model.name
        self.number.text = model.number
        
        let nicknames = model.name?.components(separatedBy: " ")
        var nickname = ""
       
        for name in nicknames! {
            if name != "" && nickname.count < 2{
                nickname = nickname + String(name.first!)
            }
            
        }
        self.nickname.text = nickname
        
        
        
    }

}

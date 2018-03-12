//
//  MemberCell.swift
//  HaHaGO_Test_Swift
//
//  Created by nerochiu on 2018/3/10.
//  Copyright © 2018年 ISCOM. All rights reserved.
//

import UIKit

class MemberCell: UICollectionViewCell {

    @IBOutlet var avatarImg: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    
    public func setupUI (_ comment: GroupModel){
        
        avatarImg.sd_setImage(with: URL(string: comment.photo), placeholderImage: UIImage(named: "placeholder.png"))
        
        avatarImg.clipsToBounds = true
        avatarImg.layer.cornerRadius = avatarImg.frame.size.width/2
        
        titleLabel.text = comment.name
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

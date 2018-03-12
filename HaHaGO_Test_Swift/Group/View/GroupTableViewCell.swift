//
//  GroupTableViewCell.swift
//  HaHaGO_Test_Swift
//
//  Created by nerochiu on 2018/3/9.
//  Copyright © 2018年 ISCOM. All rights reserved.
//

import UIKit
class GroupTableViewCell: UITableViewCell {

    @IBOutlet var avatarImg: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var discLabel: UILabel!
    
    @IBOutlet var checkLabel: UILabel!
    
 
    
    public func setupUI (_ comment: GroupModel){
        
        avatarImg.sd_setImage(with: URL(string: comment.photo), placeholderImage: UIImage(named: "placeholder.png"))
        
        avatarImg.clipsToBounds = true
        avatarImg.layer.cornerRadius = avatarImg.frame.size.width/2
        
        titleLabel.text = comment.name
        
        if (comment.hasjoin == true){
            checkLabel.isHidden=false
        }else{
            checkLabel.isHidden=true
        }
        
    }
    
    public func didCell(_ comment: GroupModel,index: IndexPath){
        
        if (comment.hasjoin == true){
            checkLabel.isHidden=true
            comment.hasjoin=false

        }else{
            checkLabel.isHidden=false
            comment.hasjoin=true
        }
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  GroupModel.swift
//  HaHaGO_Test_Swift
//
//  Created by nerochiu on 2018/3/9.
//  Copyright © 2018年 ISCOM. All rights reserved.
//

import UIKit

class GroupModel: NSObject {
    var f_id :String = ""
    var hasjoin : Bool = false
    var inviterName :String = ""
    var name :String = ""
    var photo :String = ""
    var uid :String = ""

    init(dict: [String: Any]) {
        
        guard let f_id = dict["f_uid"] as? String , let hasjoin = dict["hasjoin"] as? Bool , let inviterName = dict["inviterName"] as? String ,let name = dict["name"] as? String,let photo = dict["photo"] as? String,let uid = dict["uid"] as? String else {
            
            return
        }
        
        self.f_id = f_id
        self.hasjoin = hasjoin
        self.inviterName = inviterName
        self.name = name
        self.photo = photo
        self.uid = uid
        
    }

}

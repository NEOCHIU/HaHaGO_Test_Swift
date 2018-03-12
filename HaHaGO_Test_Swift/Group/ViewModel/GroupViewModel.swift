//
//  GroupViewModel.swift
//  HaHaGO_Test_Swift
//
//  Created by nerochiu on 2018/3/9.
//  Copyright © 2018年 ISCOM. All rights reserved.
//

import UIKit
import FirebaseDatabase



class GroupViewModel: NSObject {

    var  dataArry = [GroupModel]()
    var  joinArray = [GroupModel]()
    var  searchArray = [GroupModel]()
    
    var ref: DatabaseReference = Database.database().reference()

    
    func getDataFromFirebase(boolFirstLoad:Bool, jsonBlock: @escaping ()->()){
        
       ref.observeSingleEvent(of: .value, with: { (snapshot) in
          
     
        guard snapshot is ((Any)) else {
                return
        }
            for dic in snapshot.children.allObjects as! [DataSnapshot] {
                let originData = dic.value
                let data = GroupModel(dict: originData as! [String : Any])
                self.dataArry.append(data)
            }
            self.searchArray = self.dataArry

            jsonBlock()
        })
        
        
    }
    
    
    
}

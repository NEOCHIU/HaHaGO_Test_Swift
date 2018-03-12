//
//  MemberView.swift
//  HaHaGO_Test_Swift
//
//  Created by nerochiu on 2018/3/10.
//  Copyright © 2018年 ISCOM. All rights reserved.
//

import UIKit

fileprivate let cellID = "MemberCell"

class MemberView: UIView,UICollectionViewDelegate,UICollectionViewDataSource {

    
    @IBOutlet var collectionView: UICollectionView!
    
    
    @IBOutlet var avatarView: UIView!
    
    var viewModel:GroupViewModel? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 50
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15)
        collectionView.register(UINib(nibName: "MemberCell", bundle: nil), forCellWithReuseIdentifier: "MemberCell")

    }
    
    
    fileprivate func commentsInSection(_ section: Int) -> [GroupModel] {
        
        return viewModel!.joinArray
    }
    
    fileprivate func commentInIndexPath(_ indexPath: IndexPath) -> GroupModel {
        return commentsInSection(indexPath.section)[indexPath.row]
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        if viewModel!.joinArray.count > 0 {
            avatarView.isHidden = true
        }
        else {
            avatarView.isHidden = false
        }
        return viewModel!.joinArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
   
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MemberCell
        
        cell.setupUI(commentInIndexPath(indexPath))
        
        return cell
    }

    
    public func setupView(_ content: GroupViewModel) {
    
        self.viewModel = content
        
    }

}

extension MemberView {
    
    static public func memberView() -> MemberView {
        return Bundle.main.loadNibNamed("MemberView", owner: nil, options: nil)?.last as! MemberView
        
    }
    
}



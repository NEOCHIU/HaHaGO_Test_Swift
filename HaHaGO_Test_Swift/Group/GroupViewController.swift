//
//  GroupViewController.swift
//  HaHaGO_Test_Swift
//
//  Created by nerochiu on 2018/3/9.
//  Copyright © 2018年 ISCOM. All rights reserved.
//

import UIKit
import SDWebImage

fileprivate let cellID = "GroupTableViewCell"

class GroupViewController: UIViewController {

    @IBOutlet var tableView: UITableView!

    @IBOutlet var searchBarView: UISearchBar!
    @IBOutlet var memberView: UIView!

    @IBOutlet var searchBar_Hieght: NSLayoutConstraint!
    
    @IBOutlet var searchBar_Top: NSLayoutConstraint!
    
    
    
    @IBOutlet var memberNum: UILabel!
    
    @IBOutlet var friendNum: UILabel!
    
    var marginTop:CGFloat = 0.0
    
    var groupVM = GroupViewModel()
    
    lazy var mbView: MemberView = {
        let view = MemberView.memberView()
        self.memberView.addSubview(view)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="建立群組";
        loadDataNow(firstLoad: true)
        configureView()
        
    }
    
    func configureView(){

        searchBarView.delegate=self;
        searchBarView.backgroundImage = UIImage()
        UIBarButtonItem.appearance(whenContainedInInstancesOf:  [UISearchBar.self]).title = "取消"
        
        tableView.delegate=self;
        tableView.dataSource=self;
        
        tableView.tableFooterView = UIView(frame:CGRect.zero)
        let frames = CGRect(x:0,y:0,width:0,height:CGFloat.leastNormalMagnitude)
        
        tableView.tableHeaderView = UIView(frame:frames)
        tableView.rowHeight=65
        
        tableView.register(UINib.init(nibName: "GroupTableViewCell", bundle: nil), forCellReuseIdentifier: cellID)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
// MARK:GetData
extension GroupViewController{
    fileprivate func loadDataNow(firstLoad: Bool) {
        
        groupVM.getDataFromFirebase(boolFirstLoad: firstLoad) {
            [weak self] in
            self?.tableView.reloadData()
            
            self?.mbView.setupView((self?.groupVM)!)
        }
        
        
    }
    
}

// MARK:UITableViewDataSource
extension GroupViewController: UITableViewDataSource {
    
    fileprivate func commentsInSection(_ section: Int) -> [GroupModel] {
      
        return groupVM.searchArray
    }
    
    fileprivate func commentInIndexPath(_ indexPath: IndexPath) -> GroupModel {
        return commentsInSection(indexPath.section)[indexPath.row]
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if groupVM.searchArray.count>0{
            
             self.friendNum.text = String(groupVM.searchArray.count)
             return groupVM.searchArray.count

        }
       
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
     
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! GroupTableViewCell
       
        cell.setupUI(commentInIndexPath(indexPath))
        
        return cell
    }
}

// MARK:UITableViewDelegate
extension GroupViewController:UITableViewDelegate{
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        let cell:GroupTableViewCell = tableView.cellForRow(at: indexPath) as! GroupTableViewCell
        
        cell.didCell(commentInIndexPath(indexPath),index: indexPath)
        
        if (commentInIndexPath(indexPath).hasjoin == true){
            let data = commentInIndexPath(indexPath)
            groupVM.joinArray.append(data)
            print("check joinArray count =\(groupVM.joinArray.count)")
            
            self.mbView.collectionView.reloadData()
        }else{
            print("cancelA joinArray count =\(groupVM.joinArray.count)")
            for num in 0..<groupVM.joinArray.count  {
                let data = groupVM.joinArray[num]
                if data.name == commentInIndexPath(indexPath).name{
                    groupVM.joinArray.remove(at: num)
                    self.mbView.collectionView.deleteItems(at: [IndexPath(item: num, section: 0)])
                    
                    break
                }
                
            }
            print("cancelB joinArray count=\(groupVM.joinArray.count)")
            
        }
         self.memberNum.text = String(groupVM.joinArray.count)
        
    }
    
}



// MARK:UIScrollViewDelegate
extension GroupViewController:UIScrollViewDelegate{
   
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        if (marginTop != scrollView.contentInset.top) {
            marginTop = scrollView.contentInset.top;
        }
        
        let offsetY:CGFloat = scrollView.contentOffset.y;
        let newoffsetY:CGFloat = offsetY + marginTop;
        print("newoffsetY=\(newoffsetY)")

        if (newoffsetY < 0) {
            print("newoffsetY <=\(newoffsetY)")

            searchBar_Top.constant  = 64;
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.allowAnimatedContent, animations: {
                self.searchBarView.layoutIfNeeded()
            }, completion: nil)

     
        }
        else if(newoffsetY >= 5 && newoffsetY <= 100){
            print("newoffsetY >=\(newoffsetY)")
            searchBar_Top.constant  = 10;
             UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.allowAnimatedContent, animations: {
                self.searchBarView.layoutIfNeeded()
             }, completion: nil)
        }

    }


}

// MARK: UISearchBarDelegate
extension GroupViewController:UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        self.groupVM.searchArray.removeAll()

        if searchText.count != 0 {
            searchTableList()
        }

    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        groupVM.searchArray.removeAll()
        searchTableList()
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        groupVM.searchArray.removeAll()
        groupVM.searchArray = groupVM.dataArry
        tableView.reloadData()
    }

    func searchTableList(){
        let searchString: String = searchBarView.text!


        for num in 0..<groupVM.dataArry.count  {
            let data = groupVM.dataArry[num]
            let result = data.name.range(of:searchString)

            if (result != nil) {
                groupVM.searchArray.append(data)
            }
        }
        tableView.reloadData()

    }
    
}




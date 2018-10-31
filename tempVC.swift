//
//  tempVC.swift
//  KlockedUser
//
//  Created by Susheel on 24/10/18.
//  Copyright © 2018 iPhone-3. All rights reserved.
//

import UIKit

class collMain : UICollectionViewCell {
    @IBOutlet var lbl: UILabel!
}

class collFilter : UICollectionViewCell {
    @IBOutlet var lbl: UILabel!
}

class ModelStr : NSObject {
    var valStr : String = ""
    var status : Bool = false
    var valReplace : String = ""
}

class tempVC: UIViewController {

    @IBOutlet var collMain: UICollectionView!
    @IBOutlet var collFilter: UICollectionView!
    var arrPara = [ModelStr]()
    var arrFilter = [String]()
    var selectedFilterIndex : IndexPath? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let str = "Susheel R Parmar Do any additional setup after loading the view"
        arrFilter = ["Susheel", "additional"]
        let arrStr = str.split(separator: " ")
        
        for str in arrStr {
            let arr = arrFilter.filter(){$0 == str}
            
            let objModelStr = ModelStr()
            objModelStr.valStr = String(str)
            objModelStr.status = arr.count > 0 ? false : true
            arrPara.append(objModelStr)
        }
        collMain.delegate = self
        collMain.dataSource = self
        collMain.reloadData()
        collFilter.delegate = self
        collFilter.dataSource = self
        collFilter.reloadData()
        print(arrStr)

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension tempVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collMain {
            return arrPara.count
        }
        else {
            return arrFilter.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collMain {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collMain", for: indexPath) as! collMain
            let objModelStr = arrPara[indexPath.row] as ModelStr
            if objModelStr.status == false {
                cell.lbl.backgroundColor = UIColor.blue
                if objModelStr.valReplace == "" {
                    cell.lbl.text = objModelStr.valStr
                    cell.lbl.textColor = UIColor.blue
                }
                else {
                    cell.lbl.textColor = UIColor.white
                    cell.lbl.text = objModelStr.valReplace
                }
            }
            else {
                cell.lbl.text = objModelStr.valStr
                cell.lbl.textColor = UIColor.black
                cell.lbl.backgroundColor = UIColor.clear
            }
            cell.lbl.font = UIFont(name: AppConstants.AppFont.regFont, size: 15)
            cell.lbl.text = objModelStr.valStr
            
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collFilter", for: indexPath) as! collFilter
            let str = arrFilter[indexPath.row]
            cell.lbl.font = UIFont(name: AppConstants.AppFont.regFont, size: 15)
            cell.lbl.text = str
            return cell
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collMain {
            let lbl = UILabel()
            lbl.font = UIFont(name: AppConstants.AppFont.regFont, size: 15)
            let objModelStr = arrPara[indexPath.row] as ModelStr
            lbl.text = objModelStr.valStr
            return lbl.intrinsicContentSize
        }
        else{
            let lbl = UILabel()
            lbl.font = UIFont(name: AppConstants.AppFont.regFont, size: 15)
            let str = arrFilter[indexPath.row]
            lbl.text = str
            return lbl.intrinsicContentSize
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collFilter {
            selectedFilterIndex = indexPath
        }
        else {
            if selectedFilterIndex != nil {
                let obj = arrPara[indexPath.row]
                let str = arrFilter[(selectedFilterIndex?.row)!]
                for obj1 in arrPara {
                    if obj1.valReplace == str  {
                        obj1.valReplace = ""
                    }
                }
                obj.valReplace = arrFilter[(selectedFilterIndex?.row)!]
                selectedFilterIndex = nil
                collMain.reloadData()
            }
      
        }
    }
}

//
//  ClassScheduleViewController.swift
//  ClassSchedule
//
//  Created by 謝佳瑋 on 2017/10/13.
//  Copyright © 2017年 BIRC. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result

class ClassScheduleViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,UICollectionViewDelegateFlowLayout,UISearchBarDelegate {
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var weekScrollView: UIScrollView!
    @IBOutlet weak var unitScrollView: UIScrollView!
    @IBOutlet weak var scheduleScrollView: UIScrollView!
    @IBOutlet weak var searchBar: UISearchBar!
    var upCol : UICollectionView!
    var leftCol : UICollectionView!
    var centerCol : UICollectionView!
    lazy var viewModel = {
        return ClassScheduleViewModel(collectionView: self.centerCol)
    }()
    var viewModelObserver: NSKeyValueObservation!
    
    let units = ["一", "二", "三", "四", "五", "六", "日"]
    let times = [
        "第一節\n08:10\n09:00",
        "第二節\n09:10\n10:00",
        "第三節\n10:10\n11:00",
        "第四節\n11:10\n12:00",
        "第五節\n13:30\n14:20",
        "第六節\n14:25\n15:15",
        "第七節\n15:25\n16:15",
        "第八節\n16:20\n17:10",
        "第九節\n17:15\n18:05",
        "第十節",
        "第十一節\n18:30\n19:15",
        "第十二節\n19:20\n20:05",
        "第十三節\n20:15\n21:00",
        "第十四節\n21:05\n21:50"
                ]
    let colLeft:CGFloat = 14.0
    let colUp:CGFloat = 7.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.delegate = self
        setView()
        viewModel.reloadCollectionView()
    }
    
    func setView(){
        let upLayout = UICollectionViewFlowLayout()
        upLayout.minimumLineSpacing = 0.0
        upLayout.minimumInteritemSpacing = 0.0
        
        let leftLayout = UICollectionViewFlowLayout()
        leftLayout.minimumLineSpacing = 0.0
        leftLayout.minimumInteritemSpacing = 0.0
        
        let centerLayout = UICollectionViewFlowLayout()
        centerLayout.minimumLineSpacing = 0.0
        centerLayout.minimumInteritemSpacing = 0.0
        centerLayout.scrollDirection = .horizontal
        
        let baseW = unitLabel.bounds.width
        let baseH = unitLabel.bounds.height
        
        
        upCol = UICollectionView(frame: CGRect(x: 0, y: 0, width: baseW * colUp, height: baseH) , collectionViewLayout: upLayout)
        leftCol = UICollectionView(frame: CGRect(x: 0, y: 0, width: baseW, height: baseW * colLeft), collectionViewLayout: leftLayout)
        centerCol = UICollectionView(frame: CGRect(x: 0, y: 0, width: baseW * colUp, height: baseW * colLeft), collectionViewLayout: centerLayout)
        
        let nib1 = UINib(nibName: "OutSideCollectionViewCell", bundle: nil)
        let nib2 = UINib(nibName: "OutSideCollectionViewCell", bundle: nil)
        let nib3 = UINib(nibName: "CourseCollectionViewCell", bundle: nil)
        upCol.register(nib1, forCellWithReuseIdentifier: "OutSideCollectionViewCell")
        leftCol.register(nib2, forCellWithReuseIdentifier: "OutSideCollectionViewCell")
        centerCol.register(nib3, forCellWithReuseIdentifier: "CourseCollectionViewCell")
        
        upCol.delegate = self
        upCol.dataSource = self
        upCol.isScrollEnabled = false
        
        leftCol.delegate = self
        leftCol.dataSource = self
        leftCol.isScrollEnabled = false
        
        centerCol.delegate = self
        centerCol.dataSource = self
        
        
        upCol.backgroundColor = UIColor.secondary
        leftCol.backgroundColor = UIColor.secondary
        centerCol.backgroundColor = UIColor.secondaryLight
        
        weekScrollView.addSubview(upCol)
        unitScrollView.addSubview(leftCol)
        scheduleScrollView.addSubview(centerCol)
        
        scheduleScrollView.delegate = self
        
        weekScrollView.contentSize.width = baseW * colUp
        unitScrollView.contentSize.height = baseW * colLeft
        scheduleScrollView.contentSize.width = baseW * colUp
        scheduleScrollView.contentSize.height = baseW * colLeft
        
        unitLabel.layer.borderWidth = 0.5
        unitLabel.layer.borderColor = UIColor.primaryLight.cgColor
        unitLabel.backgroundColor = UIColor.secondary
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let baseW = unitLabel.bounds.width
        let baseH = unitLabel.bounds.height
        
        if collectionView == upCol {
            return CGSize(width: baseW, height: baseH)
        }
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case upCol:
            return Int(colUp)
        case leftCol:
            return Int(colLeft)
        case centerCol:
            return 98
        default:
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == centerCol {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CourseCollectionViewCell", for: indexPath) as! CourseCollectionViewCell
            
            func resetCell(){
                cell.name.text = ""
                cell.room.text = ""
                cell.teacher.text = ""
            }
            
            guard viewModel.classScheduleModels.count != 0 else{
                resetCell()
                return cell
            }
            
            let classSchedule = viewModel.classScheduleModels[indexPath.row]
            let cours = classSchedule.cours
            
            courseCellGetData(cell, data: cours)
            
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OutSideCollectionViewCell", for: indexPath) as! OutSideCollectionViewCell
            if collectionView == leftCol{
                cell.item.text = times[indexPath.row]
            }else{
                cell.item.text = units[indexPath.row]
            }
            return cell
        }
        
        
    }
    
    func courseCellGetData(_ cell: CourseCollectionViewCell,data: CoursModel?){
        cell.name.text = data?.name ?? ""
        cell.room.text = data?.room ?? ""
        cell.teacher.text = data?.teacher ?? ""
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        weekScrollView.contentOffset.x = scheduleScrollView.contentOffset.x
        unitScrollView.contentOffset.y = scheduleScrollView.contentOffset.y
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 4 {
            // TODO: 學號格式驗證
            viewModel.search(from: searchText)
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
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

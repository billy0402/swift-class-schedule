//
//  ClassScheduleViewController.swift
//  ClassSchedule
//
//  Created by 謝佳瑋 on 2017/10/13.
//  Copyright © 2017年 BIRC. All rights reserved.
//

import UIKit
import RxSwift

class ClassScheduleViewController: UIViewController {
    
    @IBOutlet weak var sessionLabel: UILabel!
    @IBOutlet weak var weekScrollView: UIScrollView!
    @IBOutlet weak var sessionScrollView: UIScrollView!
    @IBOutlet weak var courseScrollView: UIScrollView!
    @IBOutlet weak var searchBar: UISearchBar!
    var topCol : UICollectionView!
    var leftCol : UICollectionView!
    var centerCol : UICollectionView!
    lazy var viewModel = {
        return ClassScheduleViewModel(sessionCol: self.leftCol, courseCol: self.centerCol)
    }()
    
    let weeks = ["一", "二", "三", "四", "五", "六", "日"]
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
        
        let baseW = sessionLabel.bounds.width
        let baseH = sessionLabel.bounds.height
        
        
        topCol = UICollectionView(frame: CGRect(x: 0, y: 0, width: baseW * colUp, height: baseH) , collectionViewLayout: upLayout)
        leftCol = UICollectionView(frame: CGRect(x: 0, y: 0, width: baseW, height: baseW * colLeft), collectionViewLayout: leftLayout)
        centerCol = UICollectionView(frame: CGRect(x: 0, y: 0, width: baseW * colUp, height: baseW * colLeft), collectionViewLayout: centerLayout)
        
        let nib1 = UINib(nibName: "OutSideCollectionViewCell", bundle: nil)
        let nib2 = UINib(nibName: "OutSideCollectionViewCell", bundle: nil)
        let nib3 = UINib(nibName: "CourseCollectionViewCell", bundle: nil)
        topCol.register(nib1, forCellWithReuseIdentifier: "OutSideCollectionViewCell")
        leftCol.register(nib2, forCellWithReuseIdentifier: "OutSideCollectionViewCell")
        centerCol.register(nib3, forCellWithReuseIdentifier: "CourseCollectionViewCell")
        
        topCol.delegate = self
        topCol.dataSource = self
        topCol.isScrollEnabled = false
        
        leftCol.delegate = self
        leftCol.dataSource = self
        leftCol.isScrollEnabled = false
        
        centerCol.delegate = self
        centerCol.dataSource = self
        
        
        topCol.backgroundColor = UIColor.secondary
        leftCol.backgroundColor = UIColor.secondary
        centerCol.backgroundColor = UIColor.secondaryLight
        
        weekScrollView.addSubview(topCol)
        sessionScrollView.addSubview(leftCol)
        courseScrollView.addSubview(centerCol)
        
        courseScrollView.delegate = self
        
        weekScrollView.contentSize.width = baseW * colUp
        sessionScrollView.contentSize.height = baseW * colLeft
        courseScrollView.contentSize.width = baseW * colUp
        courseScrollView.contentSize.height = baseW * colLeft
        
        sessionLabel.layer.borderWidth = 0.5
        sessionLabel.layer.borderColor = UIColor.primaryLight.cgColor
        sessionLabel.backgroundColor = UIColor.secondary
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

extension ClassScheduleViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let baseW = sessionLabel.bounds.width
        let baseH = sessionLabel.bounds.height
        
        if collectionView == topCol {
            return CGSize(width: baseW, height: baseH)
        }
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case topCol:
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
            
            guard !viewModel.courseModels.isEmpty else {
                resetCell()
                return cell
            }
            
            let classSchedule = viewModel.courseModels[indexPath.row]
            let subject = classSchedule.subject
            
            courseCellGetData(cell, data: subject)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OutSideCollectionViewCell", for: indexPath) as! OutSideCollectionViewCell
            if collectionView == leftCol {
                cell.item.text = viewModel.sessionModels[indexPath.row]
            } else {
                cell.item.text = weeks[indexPath.row]
            }
            return cell
        }
        
    }
    
    func courseCellGetData(_ cell: CourseCollectionViewCell,data: SubjectModel?){
        cell.name.text = data?.name ?? ""
        cell.teacher.text = data?.teacher ?? ""
        cell.room.text = data?.room ?? ""
    }
    
}

extension ClassScheduleViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        weekScrollView.contentOffset.x = courseScrollView.contentOffset.x
        sessionScrollView.contentOffset.y = courseScrollView.contentOffset.y
    }
    
}

extension ClassScheduleViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 4 {
            // TODO: 學號格式驗證
            viewModel.search(from: searchText)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}

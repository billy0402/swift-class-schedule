//
//  ClassScheduleViewModel.swift
//  ClassSchedule
//
//  Created by 謝佳瑋 on 2017/10/16.
//  Copyright © 2017年 BIRC. All rights reserved.
//

import Foundation
import UIKit
import Moya
import ObjectMapper
import RealmSwift

class ClassScheduleViewModel {
    private let provider = MoyaProvider<APIManager>()
    private var id:String = ""
    private var db:RealmManager?
    
    var collectionView:UICollectionView?
    var classScheduleModels:[ClassScheduleModel] = Array<ClassScheduleModel>()
    
    init(studentID id:String) {
        self.id = id
        self.db = RealmManager(realm: try! Realm())
//        ToDo: NO network handle
//        let query = NSPredicate(format:"id = \(id)")
//        let isFound = db?.read(model: ClassScheduleModel.self, condition: query, sortBy: nil)
        self.netLoadData()
    }
    
    func netLoadData(){
        provider.reactive.requestWithProgress(.getCourse(id)).start{ event in
            switch event {
            case let .value(response):
                do {
                    let json = try response.response?.filterSuccessfulStatusCodes().mapJSON()
                    self.processSuccess(json)
                }catch let error{
                    self.processError(error)
                }
            case let .failed(error):
                self.processFailed(error)
            default:
                break
            }
        }
    }
    
    func processSuccess(_ data:Any?){
        // START: JSON HANDLE
        if let json = data {
            let dic = json as! Dictionary<String,Any?>
            if (dic["status_code"] as! Int) == 200 && (dic["success"] as! Bool){
                
                
                // START: MODEL HANDLE
                if let weak = dic["result"]{
                    var models = [ClassScheduleModel]()
                    for (weekIndex,week) in zip(0..., (weak as! Array<Any?>)){
                        
                        for (unitIndex, unit) in zip(0..., (week as! Array<Dictionary<String,String?>?>)){
                            if let v = unit {
                                let cours = CoursModel(value: v)
                                //self.findCours(cours)
                                let classSchedule = ClassScheduleModel()
                                classSchedule.id = id
                                classSchedule.cours = cours
                                classSchedule.weak.value = weekIndex
                                classSchedule.unit.value = unitIndex
                                //dbDataCreater([cours,classSchedule])
                                models.append(classSchedule)
                            }else{
                                models.append(ClassScheduleModel())
                            }
                        }
                        
                    }
                    
                    self.classScheduleModels = models
                    self.reloadCollectionView()
                }
                // END: MODEL HANDLE
                
            }
        }
        // END: JSON HANDLE
    }
    
    // TODO : 檢查課程是否存在 Return Model
    func findCours(_ model:CoursModel){
        DispatchQueue.main.async {
            let cond = "teacher = \'\(String(describing: model.teacher!))\' AND name = \'\(String(describing: model.name!))\' AND room = \'\(String(describing: model.room!))\'"
            let qery = NSPredicate(format: cond)
            let m = self.db?.read(model: CoursModel.self, condition: qery, sortBy: nil)
            print(m!)
            
        }
    }
    
    func dbDataCreater(_ objects:[Object]){
        DispatchQueue.main.async{
            for object in objects{
                
                _ = self.db?.createOrUpdate(model: object)
            }
        }
    }
    
    func reloadCollectionView(){
        collectionView?.reloadData()
    }
    
    // TODO: Error handle
    func processError(_ error:Error){
        //return error.localizedDescription
    }
    
    // TODO: Error Failed
    func processFailed(_ error:MoyaError){
        //return error.failureReason!
    }
    
    
}

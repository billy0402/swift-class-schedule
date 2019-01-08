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

class ClassScheduleViewModel {
    private let provider = MoyaProvider<APIManager>()
    private var id: String = ""
    
    var collectionView: UICollectionView?
    var classScheduleModels: [ClassScheduleModel] = Array<ClassScheduleModel>()
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        getLocalData()
    }
    
    func search(from id: String) {
        self.id = id
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
    
    func processSuccess(_ data: Any?){
        // START: JSON HANDLE
        if let json = data {
            let list = json as! [[[String: Any]?]]
            var models = [ClassScheduleModel]()
            for (weekIndex,week) in zip(0..., list){
                var data: [String: Any] = [:]
                for (unitIndex, unit) in zip(0..., week){
                    if let v = unit {
                        data = ["id": id, "cours": v, "week": weekIndex, "unit": unitIndex]
                    }else{
                        data = ["id": id, "week": weekIndex, "unit": unitIndex]
                    }
                    let classSchedule = ClassScheduleModel(JSON: data)
                    models.append(classSchedule!)
                }
                
            }
            
            classScheduleModels = models
            saveToLocal()
            reloadCollectionView()
        }
        // END: JSON HANDLE
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
    
    private func saveToLocal() {
        let data = try? JSONEncoder().encode(classScheduleModels)
        
        if let json = data {
            let str = String(data: json, encoding: .utf8)
            UserDefaults.standard.set(str, forKey: "ntub-app")
        }
    }
    
    private func getLocalData() {
        let data = UserDefaults.standard.string(forKey: "ntub-app")
        if let json = data?.data(using: .utf8) {
            let models = try? JSONDecoder().decode([ClassScheduleModel].self, from: json)
            classScheduleModels = models ?? []
            reloadCollectionView()
        }
    }
    
}

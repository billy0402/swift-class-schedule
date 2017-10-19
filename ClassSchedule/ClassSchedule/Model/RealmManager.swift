//
//  RealmManager.swift
//  ClassSchedule
//
//  Created by 謝佳瑋 on 2017/10/18.
//  Copyright © 2017年 BIRC. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    var realm:Realm?
    
    init(realm:Realm) {
        self.realm = realm
    }
    
    func createOrUpdate(model:Object,condition:((_ realm:Realm) -> Bool)? = nil)->Bool?{
        
        if let query = condition {
            let result = query(realm!)
            guard result else {
                return false
            }
        }
        
        do {
            try self.realm?.write {
                self.realm?.add(model, update: true)
            }
        }catch{
            return false
        }
        
        
        return true
    }
    
    func createOrUpdate(model:Object.Type,value:Dictionary<String,Any> ,
                        condition:((_ realm:Realm) -> Bool)? = nil)->Bool?{
        if let query = condition {
            let result = query(realm!)
            guard result else {
                return false
            }
        }
        
        do {
            try! self.realm?.write {
                self.realm?.create(model, value: value, update: true)
            }
        }
        
        
        return true
    }
    
    func delete(model:Object.Type,condition:((_ model:Object.Type) -> Object)? = nil)->Bool?{
        
        guard let data = condition else {
            return false
        }
        
        DispatchQueue.main.async {
            try! self.realm?.write {
                self.realm?.delete(data(model))
            }
        }
        
        return true
    }
    
    
    func read(model:Object.Type, condition:NSPredicate?, sortBy:String?, isASE:Bool=false)->Results<Object>?{
        
        var data:Results<Object>?
        
        
        if let query = condition {
            
            if let sort = sortBy{
                data = self.realm?.objects(model).filter(query).sorted(byKeyPath: sort, ascending: isASE)
            }else{
                data = self.realm?.objects(model).filter(query)
            }
        }else{
            data = self.realm?.objects(model)
        }
        print("REALM read")
        return data
        
        
    }
    
    func readAll(model:Object.Type,sortBy:String?,isASE:Bool)->Results<Object>?{
        
        var data:Results<Object>?
        
        
        
        if let sort = sortBy{
            data = self.realm?.objects(model).sorted(byKeyPath: sort, ascending: isASE)
        }else{
            data = self.realm?.objects(model)
        }
        print("REALM readAll")
        return data
        
        
    }
}

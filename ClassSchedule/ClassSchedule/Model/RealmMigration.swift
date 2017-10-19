//
//  RealmMigration.swift
//  ClassSchedule
//
//  Created by 謝佳瑋 on 2017/10/18.
//  Copyright © 2017年 BIRC. All rights reserved.
//

import Foundation

import Foundation
import RealmSwift

class RealmMigration {
    
    
    func didApplicationLunch () {
        self.migrationVersion()
    }
    
    func migrationVersion() {
        
        
        let config = Realm.Configuration(schemaVersion : 1 ,migrationBlock : { migration , oldSchemaVersion in
            //                if (oldSchemaVersion < 1) {
            //                    針對舊板本遷移到新板本的資料改變，寫在這裡。
            //                    參考官方的範例
            //                }
                        })
        
        Realm.Configuration.defaultConfiguration = config
        
    }
    
}

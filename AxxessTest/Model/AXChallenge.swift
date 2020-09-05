//
//  AXChallenge.swift
//  AxxessTest
//
//  Created by Hemil Modi on 05/09/20.
//  Copyright © 2020 Hemil Modi. All rights reserved.
//

import UIKit
import RealmSwift

struct API {
    struct ResponseKeys {
        static let id:String = "id"
        static let type:String = "type"
        static let date:String = "date"
        static let data:String = "data"
        
    }
}
class AXChallenge: Object {
   @objc dynamic var id:Int = 0
   @objc dynamic var type:String = ChallengeType.none.rawValue
   @objc dynamic var date:String = ""
   @objc dynamic var data:String = ""
    required init() {
        super.init()
        self.id = -1
        self.type = ChallengeType.none.rawValue
        self.date = ""
        self.data = ""
        
    }
    convenience init(withDictionary dict:[String:Any]) {
        self.init()
        if let value:Int = dict[API.ResponseKeys.id] as? Int {
            self.id = value
        }
        if let value:String = dict[API.ResponseKeys.type] as? String{
            self.type = value
        }
        if let value:String = dict[API.ResponseKeys.date] as? String{
            self.date = value
        }
        if let value:String = dict[API.ResponseKeys.data] as? String{
            self.data = value
        }
    }
    
}


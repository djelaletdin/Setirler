//
//  PoemRealmData.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 2021/07/31.
//

import Foundation
import RealmSwift

class PoemRealmData: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var content = ""
    @objc dynamic var poetName = ""
    
}

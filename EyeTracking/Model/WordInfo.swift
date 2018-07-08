//
//  WordInfo.swift
//  EyeTracking
//
//  Created by 양종열 on 2018. 7. 7..
//  Copyright © 2018년 hackathon. All rights reserved.
//

import Foundation
import RealmSwift

class WordInfo: Object {
    @objc dynamic var word: String = ""
    @objc dynamic var noun: String = ""
    @objc dynamic var verb: String = ""
}

func addWord(_ word: String, _ noun: String, _ verb: String) {
    let realm = try! Realm()
    let object = WordInfo()
    object.word = word
    object.noun = noun
    object.verb = verb
    try! realm.write{
        realm.add(object)
    }
}

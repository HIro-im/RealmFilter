//
//  Filter.swift
//  RealmFilter
//
//  Created by 今橋浩樹 on 2022/08/10.
//

import Foundation
import RealmSwift

class Memo: Object {
    @Persisted(primaryKey: true)var id = 0
    @Persisted var text = ""
    @Persisted var selectedButton = 0
}

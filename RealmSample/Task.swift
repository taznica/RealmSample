//
// Created by Taichi Tsuchida on 2018/07/19.
// Copyright (c) 2018 Taichi Tsuchida. All rights reserved.
//

import UIKit
import RealmSwift

class Task: Object {

    static let realm = try! Realm()

    @objc dynamic var id: Int = 0
    @objc dynamic var value: String = ""


    // 初期化を行う
    convenience init(value: String) {
        self.init()
        self.id = self.newId()
        self.value = value
    }


    // idをプライマリキーに設定する
    override class func primaryKey() -> String? {
        return "id"
    }


    // taskを追加する
    func add() {
        try! Task.realm.write({
            Task.realm.add(self)
        })
    }

    // taskを全件取得する
    func readAll() -> [Task] {
        let tasks = Task.realm.objects(Task.self).sorted(byKeyPath: "id", ascending: true)
        var list: [Task] = []

        for task in tasks {
            list.append(task)
        }

        return list
    }


    // taskを更新する
    func update(task: Task, value: String) {
        try! Task.realm.write({
            task.value = value
        })
    }


    // taskを削除する
    func delete(id: Int) {
        let task = Task.realm.objects(Task.self)[id]

        try! Task.realm.write({
            Task.realm.delete(task)
        })
    }


    // taskの最新idを取得する
    func newId() -> Int {
        if let last = Task.realm.objects(Task.self).last {
            return last.id + 1
        }
        else {
            return 1
        }
    }
}

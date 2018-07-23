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


    convenience init(value: String) {
        self.init()
        self.id = self.lastId()
        self.value = value
    }


    func add() {
        try! Task.realm.write({
            Task.realm.add(self)
        })
    }


    func read() -> [Task] {
        let tasks = Task.realm.objects(Task.self).sorted(byKeyPath: "id", ascending: true)
        var list: [Task] = []

        for task in tasks {
            list.append(task)
        }

        return list
    }


    func update(task: Task, value: String) {
        try! Task.realm.write({
            task.value = value
        })
    }


    func delete(id: Int) {
        let task = Task.realm.objects(Task.self)[id]

        try! Task.realm.write({
            Task.realm.delete(task)
        })
    }


    func lastId() -> Int {
        if let last = Task.realm.objects(Task.self).last {
            return last.id + 1
        }
        else {
            return 1
        }
    }
}

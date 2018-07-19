//
//  ViewController.swift
//  RealmSample
//
//  Created by Taichi Tsuchida on 2018/07/05.
//  Copyright © 2018年 Taichi Tsuchida. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource {

    @IBOutlet var table: UITableView!

    var tasks: [Task] = []
    var task: Task! = Task()


    override func viewDidLoad() {
        super.viewDidLoad()

        table.dataSource = self
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.read()
    }


    func read() {
        tasks = task.read()
        table.reloadData()
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
        // TODO: count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = tasks[indexPath.row].value

        return cell!
    }
}


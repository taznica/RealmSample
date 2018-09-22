//
//  ViewController.swift
//  RealmSample
//
//  Created by Taichi Tsuchida on 2018/07/05.
//  Copyright © 2018年 Taichi Tsuchida. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var table: UITableView!

    var tasks: [Task] = []
    var task: Task! = Task()


    override func viewDidLoad() {
        super.viewDidLoad()

        table.dataSource = self
        table.delegate = self
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.read()
    }


    func read() {
        tasks = task.readAll()
        table.reloadData()
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = tasks[indexPath.row].value

        return cell!
    }


    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }


    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete: UITableViewRowAction = UITableViewRowAction(style: .destructive, title: "delete", handler: {(action, indexPath) in

            let task: Task = Task.realm.objects(Task.self)[indexPath.row]

            try! Task.realm.write {
                Task.realm.delete(task)
            }

            self.read()
        })

        return [delete]
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.goToUpdateView()
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let addViewController = segue.destination as! AddViewController

        switch segue.identifier {
            case "add":
                addViewController.viewType = .add
            
            case "update":
                let tasks = self.task.readAll()
                let task = tasks[(table.indexPathForSelectedRow?.row)!]
                
                addViewController.viewType = .update
                addViewController.task = task
            
            default:
                break
        }
    }


    func goToAddView() {
        self.performSegue(withIdentifier: "add", sender: nil)
    }


    func goToUpdateView() {
        self.performSegue(withIdentifier: "update", sender: nil)
    }


    @IBAction func didSelectAddButton() {
        self.goToAddView()
    }
}

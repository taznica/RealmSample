//
//  ViewController.swift
//  RealmSample
//
//  Created by Taichi Tsuchida on 2018/07/05.
//  Copyright © 2018年 Taichi Tsuchida. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var table: UITableView!

    var tasks: [Task] = []
    var task: Task! = Task()


    override func viewDidLoad() {
        super.viewDidLoad()

        // TableViewのdataSourceとdelegateのメソッドをListViewControllerで呼ぶようにする
        // Make TableView dataSource and delegate methods called in ListViewController.
        table.dataSource = self
        table.delegate = self
    }


    // 画面表示時の動作を設定する
    // Set the operation when displaying the view.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // 画面表示時にRealmからデータを読み込みTableViewに表示する
        // Read data from Realm and display it on TableView when displaying the view.
        self.read()
    }


    // Realmからのデータにの読み込みとTableViewの更新を行う
    // Read data from Realm and update TableView.
    func read() {
        tasks = task.readAll()
        table.reloadData()
    }


    // 画面遷移時の設定をする
    // Make settings for view transition.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let addViewController = segue.destination as! AddViewController

        // 追加か更新かで遷移時の処理を変える
        // Change processing at transition by add or update.
        switch segue.identifier {
        case "add":
            addViewController.viewType = .add

        case "update":
            // タップされたセルのデータを取得し更新画面に受け渡す
            // Acquires the data of the tapped cell and passes it to the update view.
            let task = tasks[(table.indexPathForSelectedRow?.row)!]

            addViewController.viewType = .update
            addViewController.task = task

        default:
            break
        }
    }


    // 追加画面に遷移する
    // Transit to add view.
    func transitToAddView() {
        self.performSegue(withIdentifier: "add", sender: nil)
    }


    // 更新画面に遷移する
    // Transit to update view.
    func transitToUpdateView() {
        self.performSegue(withIdentifier: "update", sender: nil)
    }


    // 追加(+)ボタンをタップしたときの動作を設定する
    // Set action when tapping add(+) button.
    @IBAction func didSelectPlusButton() {

        // 追加画面に遷移する
        // Transit to add view.
        self.transitToAddView()
    }


    // TableViewのセル数を設定する
    // Set the number of cells in TableView.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }


    // セルに表示する内容を設定する
    // Set contents to display in cell.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")

        // taskの内容をセルに表示する
        // Display contents of task in cell.
        cell?.textLabel?.text = tasks[indexPath.row].value

        return cell!
    }


    // セルを編集可能にする
    // Make the cell editable.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }


    // セルをスワイプしたときの設定をする
    // Make settings when swiping cells.
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // 削除ボタンを追加する
        // Add delete button.
        let delete: UITableViewRowAction = UITableViewRowAction(style: .destructive, title: "delete", handler: {(action, indexPath) in

            // スワイプされたセルのtaskを取得する
            // Get the task of the swiped cell.
            let task = self.tasks[indexPath.row]

            // taskを削除する
            // Delete the task.
            try! Task.realm.write {
                Task.realm.delete(task)
            }

            // TableViewを更新する
            // Update the TableView.
            self.read()
        })

        return [delete]
    }


    // セルをタップしたときの動作を設定する
    // Set the behavior when tapping a cell.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        // 更新画面に遷移する
        // Transit to update view.
        self.transitToUpdateView()
    }
}

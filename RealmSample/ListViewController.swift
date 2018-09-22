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
        table.dataSource = self
        table.delegate = self
    }


    // 画面表示時の動作を設定する
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // 画面表示時にRealmからデータを読み込みTableViewに表示する
        self.read()
    }


    // Realmからのデータを読み込みとTableViewの更新を行う
    func read() {
        tasks = task.readAll()
        table.reloadData()
    }


    // TableViewのセル数を設定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }


    // セルに表示する内容を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")

        // taskの内容をセルに表示する
        cell?.textLabel?.text = tasks[indexPath.row].value

        return cell!
    }


    // セルを編集可能にする
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }


    // セルをスワイプしたときの設定をする
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        // 削除ボタンを追加する
        let delete: UITableViewRowAction = UITableViewRowAction(style: .destructive, title: "delete", handler: {(action, indexPath) in

            // スワイプされたセルのtaskを取得する
            let task: Task = Task.realm.objects(Task.self)[indexPath.row]

            // taskを削除する
            try! Task.realm.write {
                Task.realm.delete(task)
            }

            // TableViewを更新する
            self.read()
        })

        return [delete]
    }


    // セルをタップしたときの動作を設定する
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        // 更新画面に遷移する
        self.goToUpdateView()
    }


    // 画面遷移時の設定をする
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let addViewController = segue.destination as! AddViewController

        // 追加か更新かで遷移時の処理を分ける
        switch segue.identifier {
            case "add":
                addViewController.viewType = .add
            
            case "update":
                // タップされたセルのデータを取得し更新画面に受け渡す
                let tasks = self.task.readAll()
                let task = tasks[(table.indexPathForSelectedRow?.row)!]
                
                addViewController.viewType = .update
                addViewController.task = task
            
            default:
                break
        }
    }


    // 追加画面に遷移する
    func goToAddView() {
        self.performSegue(withIdentifier: "add", sender: nil)
    }


    // 更新画面に遷移する
    func goToUpdateView() {
        self.performSegue(withIdentifier: "update", sender: nil)
    }


    // 追加ボタンをタップしたときの動作を設定する
    @IBAction func didSelectAddButton() {

        // 追加画面に遷移する
        self.goToAddView()
    }
}

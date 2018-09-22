//
//  AddViewController.swift
//  RealmSample
//
//  Created by Taichi Tsuchida on 2018/07/19.
//  Copyright © 2018年 Taichi Tsuchida. All rights reserved.
//

import UIKit


// 追加画面と更新画面を区別するためのデータ
enum ViewType {
    case add
    case update
}


class AddViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var textField: UITextField!
    @IBOutlet var button: UIButton!

    var task: Task!

    var viewType: ViewType = .add

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // 更新画面として使うときは、textFieldに内容を表示し、buttonのタイトルを変更する
        if viewType == .update {
            textField.text = task.value
            button.setTitle("Update", for: .normal)
        }
    }

    // 追加(更新)ボタンをタップしたときの動作を設定する
    @IBAction func didSelectButton() {

        // textFieldが空の場合は何も行わない
        guard let value = textField.text else {
            return
        }

        // 追加か更新かで処理を分ける
        switch viewType {
            case .add:
                // taskの追加を行う
                self.addTask(value: value)
            
            case .update:
                // taskの更新を行う
                self.updateTask(value: value)
        }

        // リスト画面に遷移する
        self.goToListView()
    }
    

    // 戻るボタンをタップしたときの動作を設定する
    @IBAction func didSelectBackButton() {

        // リスト画面に遷移する
        self.goToListView()
    }

    // taskを追加する
    func addTask(value: String) {
        let task = Task(value: value)
        task.add()
    }

    // taskを更新する
    func updateTask(value: String) {
        task.update(task: task, value: value)
    }

    // リスト画面に遷移する
    func goToListView() {
        self.navigationController?.popViewController(animated: true)
    }



    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        return true
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(textField.isFirstResponder) {
            textField.resignFirstResponder()
        }
    }
}

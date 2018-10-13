//
//  AddViewController.swift
//  RealmSample
//
//  Created by Taichi Tsuchida on 2018/07/19.
//  Copyright © 2018年 Taichi Tsuchida. All rights reserved.
//

import UIKit


// 追加画面と更新画面を区別するためのデータ
// Data for distinguishing between the add view and the update view.
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

    
    // 画面表示時の動作を設定する
    // Set the operation when displaying the view.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // 更新画面として使うときは、textFieldに内容を表示し、buttonのタイトルを変更する
        // When using as update view, display the contents in textField and change the title of button.
        if viewType == .update {
            textField.text = task.value
            button.setTitle("Update", for: .normal)
        }
    }

    
    // taskを追加する
    // Add task.
    func addTask(value: String) {
        let task = Task(value: value)
        task.add()
    }


    // taskを更新する
    // Update task.
    func updateTask(value: String) {
        task.update(task: task, value: value)
    }


    // リスト画面に遷移する
    // Transit to list view.
    func transitToListView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // textFieldが未入力の際にアラートを表示する
    // Display alert when textField is empty.
    func presentAlert() {
        
        // アラートのコントローラ
        // Controller of Alert.
        let alertController = UIAlertController(title: "The name of your task is empty.", message: "Please input the name of your task.", preferredStyle: .alert)
        
        // OKボタン
        // OK button.
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        // Add OK button to alertController.
        alertController.addAction(okAction)
        
        // アラートを表示する
        // Display the alert.
        self.present(alertController, animated: true, completion: nil)
    }


    // 追加(更新)ボタンをタップしたときの動作を設定する
    // Set the action when tapping the add (update) button.
    @IBAction func didSelectAddButton() {

        // textFieldが未入力の際にアラートを表示する
        // Display alert when textField is empty.
        guard let value = textField.text, !value.isEmpty else {
            
            // アラートを表示する
            // Display alert.
            self.presentAlert()
            
            return
        }

        // 追加か更新かで処理を分ける
        // Change processing by add or update.
        switch viewType {
            case .add:
                // taskの追加を行う
                // Add task.
                self.addTask(value: value)
            
            case .update:
                // taskの更新を行う
                // Update task.
                self.updateTask(value: value)
        }

        // リスト画面に遷移する
        // Transit to list view.
        self.transitToListView()
    }
    

    // 戻るボタンをタップしたときの動作を設定する
    // Set action when tapping back button.
    @IBAction func didSelectBackButton() {

        // リスト画面に遷移する
        // Transit to list view.
        self.transitToListView()
    }

    
    // Returnキーでキーボードを閉じる
    // Close the keyboard with Return key.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // textFieldからフォーカスを外しキーボードを閉じる
        // Focus off from textField and close keyboard.
        textField.resignFirstResponder()

        return true
    }


    // 画面がタップされたらキーボードを閉じる
    // Close the keyboard when the screen is tapped/
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(textField.isFirstResponder) {
            textField.resignFirstResponder()
        }
    }
}

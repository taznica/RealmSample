//
//  AddViewController.swift
//  RealmSample
//
//  Created by Taichi Tsuchida on 2018/07/19.
//  Copyright © 2018年 Taichi Tsuchida. All rights reserved.
//

import UIKit


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

        if viewType == .update {
            textField.text = task.value
            button.setTitle("Update", for: .normal)
        }
    }

    @IBAction func didSelectButton() {
        guard let value = textField.text else {
            return
        }

        switch viewType {
            case .add:
                self.addTask(value: value)
            
            case .update:
                self.updateTask(value: value)
        }

        self.goToListView()
    }
    
    
    @IBAction func didSelectBackButton() {
        self.goToListView()
    }


    func addTask(value: String) {
        let task = Task(value: value)
        task.add()
    }


    func updateTask(value: String) {
        task.update(task: task, value: value)
    }


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

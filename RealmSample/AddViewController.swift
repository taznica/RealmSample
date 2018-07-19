//
//  AddViewController.swift
//  RealmSample
//
//  Created by Taichi Tsuchida on 2018/07/19.
//  Copyright © 2018年 Taichi Tsuchida. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func didSelectAdd() {
        guard let value = textField.text else {
            return
        }

        self.addTask(value: value)
        self.goBack()
    }


    func addTask(value: String) {
        let task = Task(value: value)
        task.add()
    }


    func goBack() {
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

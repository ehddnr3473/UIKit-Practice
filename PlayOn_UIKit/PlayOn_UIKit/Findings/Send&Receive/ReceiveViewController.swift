//
//  ReceiveViewController.swift
//  PlayOn_UIKit
//
//  Created by 김동욱 on 2022/12/06.
//

import UIKit

class ReceiveViewController: UIViewController {

    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    var receiveText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = receiveText
    }
}

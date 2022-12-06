//
//  SendViewController.swift
//  PlayOn_UIKit
//
//  Created by 김동욱 on 2022/12/06.
//

import UIKit

class SendViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextViewController = segue.destination as? ReceiveViewController else { return }
        
        nextViewController.receiveText = textField.text ?? ""
    }
    
    @IBAction func touchUpButton(_ sender: Any) {
        performSegue(withIdentifier: "SendSegue", sender: self)
    }
    
    @IBAction func receive(_ segue: UIStoryboardSegue) {
        guard let previousViewController = segue.source as? ReceiveViewController else { return }

        label.text = previousViewController.textField.text
    }
}

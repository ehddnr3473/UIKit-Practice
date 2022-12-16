//
//  MyMVVM.swift
//  PlayOn_UIKit
//
//  Created by 김동욱 on 2022/12/16.
//

import UIKit
import Foundation

struct Counter {
    var number: Int
    
    mutating func increase() -> Int {
        number += 1
        return number
    }
}

protocol CountingViewModelProtocol: AnyObject {
    var numberString: String? { get }
    var numberDidChange: ((CountingViewModelProtocol) -> Void)? { get set }
    init(_ model: Counter)
    func increase()
}

class CountingViewModel: CountingViewModelProtocol {
    var model: Counter
    var numberString: String? {
        didSet {
            numberDidChange?(self)
        }
    }
    var numberDidChange: ((CountingViewModelProtocol) -> Void)?
    
    required init(_ model: Counter) {
        self.model = model
    }
    
    @objc func increase() {
        numberString = String(model.increase())
    }
}

class CountingViewController: UIViewController {
    // set binding
    var viewModel: CountingViewModelProtocol! {
        didSet {
            viewModel.numberDidChange = { [unowned self] viewModel in
                numberLabel.text = viewModel.numberString
            }
        }
    }
    let numberLabel = UILabel()
    let increaseNumberButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setUpView()
    }
    
    func configure() {
        increaseNumberButton.addTarget(viewModel, action: #selector(CountingViewModel.increase), for: .touchUpInside)
        increaseNumberButton.setTitle("Increase", for: .normal)
        increaseNumberButton.setTitleColor(.black, for: .normal)
    }
    
    func setUpView() {
        view.backgroundColor = .white
        view.addSubview(increaseNumberButton)
        view.addSubview(numberLabel)
        
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        increaseNumberButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            increaseNumberButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            increaseNumberButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
            numberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            numberLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50)
        ])
    }
}

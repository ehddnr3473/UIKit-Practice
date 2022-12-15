//
//  MyUIActivityIndicatorView.swift
//  PlayOn_UIKit
//
//  Created by 김동욱 on 2022/12/05.
//

import UIKit

class MyUIActivityIndicatorView: UIViewController {

    private var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.startAnimating()
        
        return activityIndicatorView
    }()
    
    private lazy var mySwitch: UISwitch = {
        let `switch` = UISwitch()
        `switch`.translatesAutoresizingMaskIntoConstraints = false
        
        `switch`.addTarget(self, action: #selector(touchUpSwitch), for: .valueChanged)
        
        return `switch`
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(activityIndicatorView)
        view.addSubview(mySwitch)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        activityIndicatorView.frame = .zero
        activityIndicatorView.center = view.center
        
        mySwitch.frame = CGRect(x: 170, y: 450, width: 0, height: 0)

    }
    
    @objc func touchUpSwitch(_ sender: UISwitch) {
        if sender.isOn {
            activityIndicatorView.stopAnimating()
        } else {
            activityIndicatorView.startAnimating()
        }
    }
}

#if DEBUG

import SwiftUI

struct MyUIActivityIndicatorViewRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }

    func makeUIViewController(context: Context) -> some UIViewController {
        MyUIActivityIndicatorView()
    }
}

struct MyUIActivityIndicatorViewRepresentablePreviewProvider: PreviewProvider {
    static var previews: some View {
        MyUIActivityIndicatorViewRepresentable()
    }
}

#endif

//
//  MyHostingViewController.swift
//  PlayOn_UIKit
//
//  Created by 김동욱 on 2023/01/02.
//

import UIKit
import SwiftUI

class MyHostingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureEmbed()
    }
    
    private func configureModal() {
        let swiftUIView = MySwiftUIView()
        let hostingController = UIHostingController(rootView: swiftUIView)
        
        // Enable automatic preferredContentSize updates on the hosting controller
        hostingController.sizingOptions = .preferredContentSize

        // popover view 사이즈가 SwiftUI 콘텐츠에 알맞게 설정됨.
        hostingController.modalPresentationStyle = .popover
        present(hostingController, animated: true)
    }
    
    @objc func pushSwiftUIView() {
        let swiftUIView = MySwiftUIView()
        let hostingController = UIHostingController(rootView: swiftUIView)
            
        navigationController?.pushViewController(hostingController, animated: true)
    }
    
    private func configureEmbed() {
        let swiftUIView = MySwiftUIView()
        let hostingController = UIHostingController(rootView: swiftUIView)
        
        // Add the hosting controller as a child view controller
        self.addChild(hostingController)
        self.view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

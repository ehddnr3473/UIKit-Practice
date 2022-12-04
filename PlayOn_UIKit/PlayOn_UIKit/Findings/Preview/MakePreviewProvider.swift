//
//  MakePreviewProvider.swift
//  PlayOn_UIKit
//
//  Created by 김동욱 on 2022/12/04.
//

#if DEBUG

import SwiftUI

struct ViewControllerRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        // return ViewController
        ViewController()
    }
}

struct ViewControllerRepresentablePreviewProvider: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable()
    }
}

#endif

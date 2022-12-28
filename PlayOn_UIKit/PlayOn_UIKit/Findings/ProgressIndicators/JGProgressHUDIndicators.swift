//
//  JGProgressHUDIndicators.swift
//  PlayOn_UIKit
//
//  Created by 김동욱 on 2022/12/16.
//

import UIKit
import JGProgressHUD

class JGProgressHUDIndicators: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.showDownloadingIndicator()
        }
    }
    
    func showBasicIndicator() {
        let hud = JGProgressHUD()
        hud.show(in: view)
    }
    
    func showTextIndicator() {
        let hud = JGProgressHUD()
        hud.textLabel.text = "Loading"
        hud.detailTextLabel.text = "Please wait"
        hud.show(in: view)
    }
    
    // 인앱 결제같은 기능에, 햅틱 진동과 함께 작동 가능.
    func showSuccessIndicator() {
        let hud = JGProgressHUD()
        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
        hud.textLabel.text = "Success!"
        hud.detailTextLabel.text = "Download complete."
        hud.show(in: view)
        hud.dismiss(afterDelay: 3)
    }
    
    func showErrorIndicator() {
        let hud = JGProgressHUD()
        hud.indicatorView = JGProgressHUDErrorIndicatorView()
        hud.textLabel.text = "Error"
        hud.textLabel.textColor = .red
        hud.hudView.backgroundColor = .systemPink
        hud.cornerRadius = 30
        hud.show(in: view)
    }
    
    func showDownloadingIndicator() {
        let hud = JGProgressHUD()
        hud.indicatorView = JGProgressHUDPieIndicatorView()
        hud.textLabel.text = "Downloading"
        hud.show(in: view)
        
        var progress: Float = 0.0
        // 3초 동안 100%를 채움.
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            progress += 0.01
            hud.setProgress(progress, animated: true)
            let value: Float = progress * 100 / 3
            hud.detailTextLabel.text = "\(Int(value))%"
            
            if progress > 3.0 {
                timer.invalidate()
                hud.dismiss(animated: true)
//                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                // ...
                self.showSuccessIndicator()
            }
        }
    }
    
    func showCustomIndicator() {
        let hud = JGProgressHUD()
        hud.indicatorView = JGProgressHUDImageIndicatorView(image: UIImage(systemName: "bell")!)
        hud.textLabel.text = "Notifications Enabled"
        hud.show(in: view)
    }
}

#if DEBUG

import SwiftUI

struct JGProgressHUDIndicatorsRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }

    func makeUIViewController(context: Context) -> some UIViewController {
        JGProgressHUDIndicators()
    }
}

struct JGProgressHUDIndicatorsRepresentablePreviewProvider: PreviewProvider {
    static var previews: some View {
        JGProgressHUDIndicatorsRepresentable()
    }
}

#endif

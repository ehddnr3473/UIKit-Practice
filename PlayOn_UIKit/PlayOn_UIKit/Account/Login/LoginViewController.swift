//
//  LoginViewController.swift
//  PlayOn_UIKit
//
//  Created by 김동욱 on 2022/11/30.
//

import UIKit
import AuthenticationServices

class LoginViewController: UIViewController {

    // MARK: - Properties
    private let signInbutton = ASAuthorizationAppleIDButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(signInbutton)
        signInbutton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signInbutton.frame = CGRect(x: 0, y: 0, width: 250, height: 50)
        signInbutton.center = view.center
    }
    
    @objc func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("FAILED")
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            // Create an account in your system.
            let userIdentifier = appleIDCredential.user
//            let fullName = appleIDCredential.fullName
//            let email = appleIDCredential.email
            
            print(userIdentifier)
            navigationController?.pushViewController(ViewController(), animated: true)
        default:
            break
        }
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}

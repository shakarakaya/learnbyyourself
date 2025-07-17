//
//  LoginViewModel.swift
//  learnbyyourself
//
//  Created by Süha Karakaya on 8.07.2025.
//

import UIKit

class LoginViewModel {
    
    
    var onAuthSuccess: (() -> Void)?
    var onErrorMessage: ((String) -> Void)?
    var onRegisterRequested: (() -> Void)?
    
    var onLoginSuccess: (() -> Void)?
    var onStatusUpdate: ((String) -> Void)?
    
    private let authService: AuthServiceProtocol

    init(authService: AuthServiceProtocol = FirebaseAuthService()) {
        self.authService = authService
    }

    func goToRegister() {
        onRegisterRequested?()
    }
    
    func login(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else {
            onErrorMessage?("E-posta ve şifre boş olamaz.")
            return
        }

        authService.signIn(email: email, password: password) { [weak self] result in
            switch result {
            case .success:
                self?.onAuthSuccess?()
            case .failure(let error):
                self?.onErrorMessage?(error.localizedDescription)
            }
        }
    }
    
    func loginWithGoogle(presentingVC: UIViewController) {
        authService.signInWithGoogle(presentingVC: presentingVC) { [weak self] result in
            switch result {
            case .success:
                self?.onAuthSuccess?()
            case .failure(let error):
                self?.onErrorMessage?(error.localizedDescription)
            }
        }
    }

}

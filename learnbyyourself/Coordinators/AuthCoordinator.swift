//
//  AuthCoordinator.swift
//  learnbyyourself
//
//  Created by Süha Karakaya on 8.07.2025.
//

import UIKit

final class AuthCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController

    var onAuthSuccess: (() -> Void)?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showLogin()
    }

    private func showLogin() {
        let viewModel = LoginViewModel()
        let loginVC = LoginViewController.instantiateFromNib()
        loginVC.viewModel = viewModel

        viewModel.onRegisterRequested = { [weak self] in
            self?.showRegister()
        }
        
        viewModel.onAuthSuccess = { [weak self] in
            self?.onAuthSuccess?()
            
        }
        
        viewModel.onLoginSuccess = { [weak self] in
            self?.onAuthSuccess?()
            
        }

        navigationController.setViewControllers([loginVC], animated: true)
    }

    private func showRegister() {
        let registerVC = RegisterViewController.instantiateFromNib()
        let viewModel = RegisterViewModel(authService: FirebaseAuthService())

        viewModel.onStatusUpdate = { message in
            registerVC.showStatus(message)
        }

        viewModel.onRegisterSuccess = { [weak self] in
            self?.onAuthSuccess?()
        }

        registerVC.viewModel = viewModel
        navigationController.pushViewController(registerVC, animated: true)
    }
}


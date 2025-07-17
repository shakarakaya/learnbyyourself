//
//  SplashCoordinator.swift
//  learnbyyourself
//
//  Created by Süha Karakaya on 17.07.2025.
//

import UIKit

final class SplashCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController

    var onFinish: (() -> Void)?  // Splash tamamlandığında haber vermek için

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = SplashViewModel()
        let splashVC = SplashViewController.instantiateFromNib()
        splashVC.viewModel = viewModel

        // Firebase config veya diğer async işlemler burada tetiklenir
        viewModel.onSetupCompleted = { [weak self] in
            // Splash bittiğinde AuthFlow'a geç
            self?.onFinish?()
        }

        navigationController.setViewControllers([splashVC], animated: false)
    }
}


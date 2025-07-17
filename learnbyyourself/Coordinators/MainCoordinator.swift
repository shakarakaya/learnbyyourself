//
//  MainCoordinator.swift
//  learnbyyourself
//
//  Created by Süha Karakaya on 8.07.2025.
//

import UIKit

final class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = MainViewModel()
        let mainVC = MainViewController.instantiateFromNib()
        mainVC.viewModel = viewModel
        navigationController.setViewControllers([mainVC], animated: true)
    }
}


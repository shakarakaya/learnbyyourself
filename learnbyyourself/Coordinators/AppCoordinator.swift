//
//  AppCoordinator.swift
//  learnbyyourself
//
//  Created by Süha Karakaya on 8.07.2025.
//

import UIKit

final class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    let window: UIWindow
    let navigationController: UINavigationController

    // Eğer ihtiyaç varsa referans olarak tut
    private var authCoordinator: AuthCoordinator?

    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        self.navigationController.setNavigationBarHidden(true, animated: false)
    }

    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        showSplash()
    }

    private func showSplash() {
        let splashCoordinator = SplashCoordinator(navigationController: navigationController)
        childCoordinators.append(splashCoordinator)

        splashCoordinator.onFinish = { [weak self, weak splashCoordinator] in
            guard let self = self, let splashCoordinator = splashCoordinator else { return }
            self.removeChild(splashCoordinator)
            self.showAuthFlow()
        }

        splashCoordinator.start()
    }


    private func showAuthFlow() {
        let authCoordinator = AuthCoordinator(navigationController: navigationController)
        self.authCoordinator = authCoordinator
        childCoordinators.append(authCoordinator)

        authCoordinator.onAuthSuccess = { [weak self, weak authCoordinator] in
            guard let self = self, let authCoordinator = authCoordinator else { return }
            self.removeChild(authCoordinator)
            self.showMain()
        }

        authCoordinator.start()
    }

    private func showMain() {
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        childCoordinators.append(mainCoordinator)
        mainCoordinator.start()
    }

    private func removeChild(_ coordinator: Coordinator) {
        childCoordinators.removeAll { $0 === coordinator }
    }
}


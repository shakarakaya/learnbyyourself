//
//  Coordinator.swift
//  learnbyyourself
//
//  Created by Süha Karakaya on 17.07.2025.
//

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
}



//
//  SplashViewModel.swift
//  learnbyyourself
//
//  Created by Süha Karakaya on 8.07.2025.
//

import Foundation

final class SplashViewModel {
    var onSetupCompleted: (() -> Void)?

    func startSetup() {
        // Firebase vs. config işlemlerini başlat
        DispatchQueue.global().async {
            // Simülasyon: 2 saniye bekle
            sleep(2)

            // İşlem bittiğinde ana thread’de callback
            DispatchQueue.main.async { [weak self] in
                self?.onSetupCompleted?()
            }
        }
    }
}


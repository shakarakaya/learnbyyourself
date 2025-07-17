//
//  RegisterViewModel.swift
//  learnbyyourself
//
//  Created by Süha Karakaya on 8.07.2025.
//

import Foundation

final class RegisterViewModel {

    private let authService: AuthServiceProtocol
    var onStatusUpdate: ((String) -> Void)?
    var onRegisterSuccess: (() -> Void)?

    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }

    func register(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else {
            onStatusUpdate?("Email ve şifre boş olamaz.")
            return
        }

        authService.register(email: email, password: password) { [weak self] result in
            switch result {
            case .success:
                self?.onStatusUpdate?("Kayıt başarılı!")
                self?.onRegisterSuccess?()
            case .failure(let error):
                self?.onStatusUpdate?("Hata: \(error.localizedDescription)")
            }
        }
    }
}


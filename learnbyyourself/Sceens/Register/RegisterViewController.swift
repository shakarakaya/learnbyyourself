//
//  RegisterViewController.swift
//  learnbyyourself
//
//  Created by Süha Karakaya on 8.07.2025.
//

import UIKit

class RegisterViewController: UIViewController, NibLoadable {
    
    var viewModel: RegisterViewModel!

    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let registerButton = UIButton(type: .system)
    private let statusLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Kayıt Ol"
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.hidesBackButton = false
    }
    
    private func setupUI() {
        emailTextField.placeholder = "Email"
        emailTextField.borderStyle = .roundedRect

        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true

        registerButton.setTitle("Kayıt Ol", for: .normal)
        registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)

        statusLabel.textColor = .systemRed
        statusLabel.numberOfLines = 0
        statusLabel.textAlignment = .center
        statusLabel.font = UIFont.systemFont(ofSize: 14)

        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, registerButton, statusLabel])
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        }

    @objc private func didTapRegister() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        viewModel.register(email: email, password: password)
    }

    func showStatus(_ message: String) {
        DispatchQueue.main.async {
            self.statusLabel.text = message
        }
    }

}

//
//  LoginViewController.swift
//  learnbyyourself
//
//  Created by Süha Karakaya on 8.07.2025.
//

import UIKit

class LoginViewController: UIViewController, NibLoadable {
    
    var viewModel: LoginViewModel!
    
    // MARK: - UI Elements

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let stackView = UIStackView()

    private let logoImageView = UIImageView()
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let forgotPasswordButton = UIButton(type: .system)
    private let rememberMeStack = UIStackView()
    private let rememberMeLabel = UILabel()
    private let rememberMeSwitch = UISwitch()

    private let loginButton = UIButton(type: .system)
    private let orSeparator = UILabel()

    private let socialButtonsStack = UIStackView()

    private let registerButton = UIButton(type: .system)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        layoutUI()
        
        viewModel.onErrorMessage = { [weak self] message in
            self?.showAlert(message: message)
        }
        
        
        viewModel.onStatusUpdate = { [weak self] message in
            self?.showAlert(message: message)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }


    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .white

        // ScrollView → ContentView
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false

        // StackView
        contentView.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // AppIcon
        logoImageView.image = UIImage(named: "login_icon")
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        stackView.addArrangedSubview(logoImageView)

        // Email
        emailTextField.placeholder = "Email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.clearButtonMode = .whileEditing
        stackView.addArrangedSubview(emailTextField)

        // Password
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.textContentType = .password
        stackView.addArrangedSubview(passwordTextField)

        // Forgot Password
        forgotPasswordButton.setTitle("Şifremi Unuttum", for: .normal)
        forgotPasswordButton.contentHorizontalAlignment = .right
        stackView.addArrangedSubview(forgotPasswordButton)

        // Remember Me
        rememberMeLabel.text = "Beni Hatırla"
        rememberMeStack.axis = .horizontal
        rememberMeStack.spacing = 8
        rememberMeStack.addArrangedSubview(rememberMeLabel)
        rememberMeStack.addArrangedSubview(rememberMeSwitch)
        stackView.addArrangedSubview(rememberMeStack)

        // Login Button
        loginButton.setTitle("Giriş Yap", for: .normal)
        loginButton.backgroundColor = .systemBlue
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 8
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        stackView.addArrangedSubview(loginButton)

        // Separator
        orSeparator.text = "──── veya ────"
        orSeparator.textAlignment = .center
        orSeparator.textColor = .lightGray
        stackView.addArrangedSubview(orSeparator)

        // Social Buttons
        socialButtonsStack.axis = .horizontal
        socialButtonsStack.spacing = 16
        socialButtonsStack.distribution = .fillEqually

        let googleButton = makeIconButton(imageName: "google_icon")
        googleButton.addTarget(self, action: #selector(handleGoogleLogin), for: .touchUpInside)

        let facebookButton = makeIconButton(imageName: "facebook_icon")
        facebookButton.addTarget(self, action: #selector(handleFacebookLogin), for: .touchUpInside)
        
        let appleButton = makeIconButton(imageName: "apple_icon")

        socialButtonsStack.addArrangedSubview(googleButton)
        socialButtonsStack.addArrangedSubview(facebookButton)
        socialButtonsStack.addArrangedSubview(appleButton)

        stackView.addArrangedSubview(socialButtonsStack)

        // Register Button
        registerButton.setTitle("Henüz hesabınız yok mu? Kayıt ol", for: .normal)
        registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        registerButton.setTitleColor(.systemBlue, for: .normal)
        stackView.addArrangedSubview(registerButton)
    }
    
    private func makeIconButton(imageName: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        return button
    }
    
    // MARK: - Layout Constraints

    private func layoutUI() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -32)
        ])
    }
    

    @objc private func didTapRegister() {
        viewModel.goToRegister()
    }

    
    @objc private func loginButtonTapped() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        viewModel.login(email: email, password: password)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func handleGoogleLogin() {
        viewModel.loginWithGoogle(presentingVC: self)
    }
    
    @objc private func handleFacebookLogin() {
        viewModel.loginWithFacebook(from: self)
    }

}

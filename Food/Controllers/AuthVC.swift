//
//  AuthVC.swift
//  Food
//
//  Created by Ayberk Öz on 8.07.2023.
//

import UIKit

class AuthVC: UIViewController,AuthViewModelDelegate {
    
    
    let authViewModel = AuthViewModel()
    
    private let foodIcon = UIImageView()
    
    private let rootStackView = UIStackView()
    private let AuthStackView = UIStackView()
    private let ButtonHstack = UIStackView()
    
    private let WelcomeLabel = UILabel()
    
    private let EmailTextField = UITextField()
    private let UsernameTextField = UITextField()
    private let passwordTextField = UITextField()
    
    private let signUpButton = UIButton()
    private let signInButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        authViewModel.delegate = self
        
        style()
        layout()
    }
    
    @objc private func signUpButtonTapped() {
        let email = EmailTextField.text?.lowercased() ?? ""
        let username = UsernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        authViewModel.signUp(email: email, username: username, password: password)
    }

    @objc private func signInButtonTapped() {
        let email = EmailTextField.text?.lowercased() ?? ""
        let password = passwordTextField.text ?? ""
        authViewModel.signIn(email: email, password: password)
    }
    
    func didSignUpSuccessfully() {
        print("User signed up successfully")
        if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
            sceneDelegate.setTabBarControllerAsRootViewController()
        }
    }

    func didSignInSuccessfully() {
        print("User signed in successfully")
        if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
            sceneDelegate.setTabBarControllerAsRootViewController()
        }
    }
    
    
    private func style() {
        view.backgroundColor = .black
        
        rootStackView.translatesAutoresizingMaskIntoConstraints = false
        rootStackView.axis = .vertical
        rootStackView.spacing = 20
        rootStackView.alignment = .center
        
        foodIcon.translatesAutoresizingMaskIntoConstraints = false
        foodIcon.contentMode = .scaleAspectFit
        foodIcon.image = UIImage(named: "Food2")
        foodIcon.backgroundColor = .white
        
        AuthStackView.translatesAutoresizingMaskIntoConstraints = false
        AuthStackView.axis = .vertical
        AuthStackView.spacing = 20
        AuthStackView.alignment = .center
        AuthStackView.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        AuthStackView.layer.cornerRadius = 20
        AuthStackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        AuthStackView.isLayoutMarginsRelativeArrangement = true
        
        WelcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        WelcomeLabel.text = "Welcome👋🏼"
        
        EmailTextField.translatesAutoresizingMaskIntoConstraints = false
        EmailTextField.placeholder = "Email"
        EmailTextField.backgroundColor = .white
        EmailTextField.layer.cornerRadius = 10
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: EmailTextField.frame.height))
        EmailTextField.leftView = paddingView
        EmailTextField.leftViewMode = .always
        
        let paddingView1 = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: EmailTextField.frame.height))
        EmailTextField.rightView = paddingView1
        EmailTextField.rightViewMode = .always
        
        UsernameTextField.translatesAutoresizingMaskIntoConstraints = false
        UsernameTextField.placeholder = "Username"
        UsernameTextField.backgroundColor = .white
        UsernameTextField.layer.cornerRadius = 10
        
        let paddingView2 = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: passwordTextField.frame.height))
        UsernameTextField.leftView = paddingView2
        UsernameTextField.leftViewMode = .always
        
        let paddingView3 = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: passwordTextField.frame.height))
        passwordTextField.rightView = paddingView3
        passwordTextField.rightViewMode = .always
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Password"
        passwordTextField.backgroundColor = .white
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.isSecureTextEntry = true
        
        let paddingView4 = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: passwordTextField.frame.height))
        passwordTextField.leftView = paddingView4
        passwordTextField.leftViewMode = .always
        
        let paddingView5 = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: passwordTextField.frame.height))
        passwordTextField.rightView = paddingView5
        passwordTextField.rightViewMode = .always
        
        ButtonHstack.translatesAutoresizingMaskIntoConstraints = false
        ButtonHstack.axis = .horizontal
        ButtonHstack.spacing = 20
        ButtonHstack.distribution = .fillEqually
        ButtonHstack.layer.cornerRadius = 20
        
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.backgroundColor = UIColor(red: 0.23, green: 0.37, blue: 0.04, alpha: 1.00)
        signUpButton.layer.cornerRadius = 10
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)

        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.backgroundColor = UIColor(red: 0.23, green: 0.37, blue: 0.04, alpha: 1.00)
        signInButton.layer.cornerRadius = 10
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
    }
    
    private func layout() {
        
        view.addSubview(rootStackView)
        
        rootStackView.addArrangedSubview(foodIcon)
        rootStackView.addArrangedSubview(AuthStackView)
        
        AuthStackView.addArrangedSubview(WelcomeLabel)
        AuthStackView.addArrangedSubview(EmailTextField)
        AuthStackView.addArrangedSubview(UsernameTextField)
        AuthStackView.addArrangedSubview(passwordTextField)
        AuthStackView.addArrangedSubview(ButtonHstack)
        
        ButtonHstack.addArrangedSubview(signInButton)
        ButtonHstack.addArrangedSubview(signUpButton)

        NSLayoutConstraint.activate([
            
            rootStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rootStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            foodIcon.widthAnchor.constraint(equalToConstant: view.frame.width / 3),
            foodIcon.heightAnchor.constraint(equalToConstant: view.frame.width / 3),

            AuthStackView.widthAnchor.constraint(equalToConstant: view.frame.width / 1.2),
            
            EmailTextField.widthAnchor.constraint(equalTo: AuthStackView.widthAnchor, multiplier: 0.8),
            EmailTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.04),
            
            UsernameTextField.widthAnchor.constraint(equalTo: AuthStackView.widthAnchor, multiplier: 0.8),
            UsernameTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.04),
            
            passwordTextField.widthAnchor.constraint(equalTo: AuthStackView.widthAnchor, multiplier: 0.8),
            passwordTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.04),
            
            ButtonHstack.widthAnchor.constraint(equalTo: AuthStackView.widthAnchor, multiplier: 0.8),
        ])
        
    }
    
}

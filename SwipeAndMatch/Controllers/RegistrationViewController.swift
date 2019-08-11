//
//  RegistrationController.swift
//  SwipeMatchFirestoreLBTA
//
//  Created by Brian Voong on 11/10/18.
//  Copyright © 2018 Brian Voong. All rights reserved.
//

import UIKit

class RegistrationController: UIViewController {
    
    // UI Components
    let selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select Photo", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 275).isActive = true
        button.layer.cornerRadius = 16
        return button
    }()
    
    let fullNameTextField: CustomTextField = {
        let tf = CustomTextField(padding: 24, height: 44)
        tf.placeholder = "Enter full name"
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        tf.backgroundColor = .white
        return tf
    }()
    let emailTextField: CustomTextField = {
        let tf = CustomTextField(padding: 24, height: 44)
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        tf.placeholder = "Enter email"
        tf.keyboardType = .emailAddress
        tf.backgroundColor = .white
        return tf
    }()
    let passwordTextField: CustomTextField = {
        let tf = CustomTextField(padding: 24, height: 44)
        tf.placeholder = "Enter password"
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        tf.isSecureTextEntry = true
        tf.backgroundColor = .white
        return tf
    }()
    
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        button.backgroundColor = #colorLiteral(red: 0.8235294118, green: 0, blue: 0.3254901961, alpha: 1)
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.layer.cornerRadius = 22
        return button
    }()
    
    lazy var verticalStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            fullNameTextField,
            emailTextField,
            passwordTextField,
            registerButton
            ])
        sv.axis = .vertical
        sv.spacing = 8
        sv.distribution = .fillEqually
        return sv
    }()
    
    lazy var stackView = UIStackView(arrangedSubviews: [
        selectPhotoButton,
        verticalStackView
        ])
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientLayer()
        setupLayout()
        setupNotificationObserver()
        setupTapGesture()
        setupRegistrationViewModel()
    }
    var registrationViewModel = RegistrationViewModel()
    
    
    func setupRegistrationViewModel(){
        registrationViewModel.isFormValidObserver = { (validForm) in
            print("Is form valid---- \(validForm)")
            self.registerButton.isEnabled = validForm
            self.registerButton.backgroundColor = validForm ? #colorLiteral(red: 0.8235294118, green: 0, blue: 0.3254901961, alpha: 1) : .gray
            self.registerButton.setTitleColor(validForm ? .white : .darkGray, for: .normal)
        }
    }
    @objc func handleTextChange(textField: UITextField)
    {
        if textField == fullNameTextField{
            registrationViewModel.fullName = textField.text
        }else if textField == emailTextField{
            registrationViewModel.email = textField.text
        }else{
            registrationViewModel.password = textField.text
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //Otherwise you will have a retain cycle as NotificationCenter is observing or is in cycle with self
        NotificationCenter.default.removeObserver(self)
    }
    func setupTapGesture(){
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissViewOnTap)))
    }
    
    @objc func dismissViewOnTap(){
        self.view.endEditing(true)
        
    }
    
    func setupNotificationObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func handleKeyboardWillShow(notification: NSNotification){
        debugPrint("Keyboard Will Show",notification)
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else{
            return
        }
        let keyboardFrame = value.cgRectValue
        debugPrint("Keyboard Frame",keyboardFrame)
        //let find the gap between stack view bottom and bottom of screen.
        let gap = view.frame.height - stackView.frame.origin.y - stackView.frame.height
        debugPrint("Gap \(gap)")
        let difference = keyboardFrame.height - gap
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.transform = CGAffineTransform(translationX: 0, y: -difference - 8)
        }, completion: nil)
    }
    
    @objc func handleKeyboardWillHide(notification: NSNotification){
        debugPrint("Keyboard Will Hide")
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.transform = .identity
        }, completion: nil)
    }
    //it noties when ever is changes in size classes of view controller (which generally happens when orientation updates
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if traitCollection.verticalSizeClass == .compact {
            stackView.axis = .horizontal
        }else{
            stackView.axis = .vertical
        }
    }
    
    func setupLayout(){
        view.addSubview(stackView)
        selectPhotoButton.widthAnchor.constraint(equalToConstant: 275).isActive = true
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 50, bottom: 0, right: 50))
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    let gradientLayer = CAGradientLayer()
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradientLayer.frame = view.bounds
    }
    fileprivate func setupGradientLayer() {
        let topColor = #colorLiteral(red: 0.9921568627, green: 0.3568627451, blue: 0.3725490196, alpha: 1)
        let bottomColor = #colorLiteral(red: 0.8980392157, green: 0, blue: 0.4470588235, alpha: 1)
        // make sure to user cgColor
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0, 1]
        view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = view.bounds
    }
    
}

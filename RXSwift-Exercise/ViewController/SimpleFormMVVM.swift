//
//  SimpleFormMVVM.swift
//  RXSwift-Exercise
//
//  Created by Robson Cesar de Siqueira on 24/11/24.
//

import UIKit
import RxSwift
import RxCocoa

class SimpleFormMVVM: UIViewController {
    
    let disposeBag = DisposeBag()
    let viewModel = SimpleFormViewModel()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter your name"
        
        return textField
    }()
    
    let lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter your last name"
        
        return textField
    }()
    
    let submitButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Submit", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 8
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
    }
    
    private func setupUI() {
        view.addSubview(nameTextField)
        view.addSubview(lastNameTextField)
        view.addSubview(submitButton)
        
        NSLayoutConstraint.activate([
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            
            lastNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            lastNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            lastNameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
            
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            submitButton.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 16),
        ])
    }
    
    private func setupBindings() {
        nameTextField.rx.text.orEmpty
            .bind(to: viewModel.name)
            .disposed(by: disposeBag)
        
        lastNameTextField.rx.text.orEmpty
            .bind(to: viewModel.lastName)
            .disposed(by: disposeBag)
        
        viewModel.isSubmitButtonEnable
            .observe(on: MainScheduler.instance)
            .bind(to: submitButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.isSubmitButtonEnable
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] isEnabled in
                self?.submitButton.backgroundColor = isEnabled ? .systemBlue : .systemGray
            }
            .disposed(by: disposeBag)
    }
}

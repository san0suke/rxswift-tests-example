//
//  ViewController.swift
//  RXSwift-Exercise
//
//  Created by Robson Cesar de Siqueira on 24/11/24.
//

import UIKit
import RxSwift
import RxCocoa

class SimpleViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    let firstTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter first value"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    let secondTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter second value"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    let resultLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 16
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
    }
    
    private func setupUI() {
        stackView.addArrangedSubview(firstTextField)
        stackView.addArrangedSubview(secondTextField)
        stackView.addArrangedSubview(resultLabel)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupBindings() {
        Observable
            .combineLatest(firstTextField.rx.text.orEmpty,
                           secondTextField.rx.text.orEmpty) { firstText, secondText in
                return "First: \(firstText)\nSecond: \(secondText)"
            }
            .bind(to: resultLabel.rx.text)
            .disposed(by: disposeBag)
    }
}


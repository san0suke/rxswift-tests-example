//
//  SimpleFormMVVMViewControllerTests.swift
//  RXSwift-Exercise
//
//  Created by Robson Cesar de Siqueira on 24/11/24.
//
import XCTest
import RxSwift
import RxCocoa
import RxTest
import RxBlocking

@testable import RXSwift_Exercise

class SimpleFormMVVMViewControllerTests: XCTestCase {
    
    var viewController: SimpleFormMVVMViewController!
    
    override func setUp() {
        super.setUp()
        
        viewController = SimpleFormMVVMViewController()
        _ = viewController.view
    }
    
    override func tearDown() {
        viewController = nil
        
        super.tearDown()
    }
    
    func testSubmitButtonIsDisableWhenFormEmpty() {
        viewController.nameTextField.text = ""
        viewController.nameTextField.sendActions(for: .editingChanged)
        
        viewController.lastNameTextField.text = ""
        viewController.lastNameTextField.sendActions(for: .editingChanged)
        
        XCTAssertFalse(viewController.submitButton.isEnabled)
    }
    
    func testSubmitButtonIsEnabledWhenFormNotEmpty() {
        viewController.nameTextField.text = "Batman"
        viewController.nameTextField.sendActions(for: .editingChanged)
        
        viewController.lastNameTextField.text = "Returns"
        viewController.lastNameTextField.sendActions(for: .editingChanged)
        
        XCTAssertTrue(viewController.submitButton.isEnabled)
    }
}

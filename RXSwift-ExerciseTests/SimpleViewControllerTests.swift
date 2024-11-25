//
//  ViewControllerTests.swift
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

class SimpleViewControllerTests: XCTestCase {
    
    var viewController: SimpleViewController!
    
    override func setUp() {
        super.setUp()
        
        // Initialize the ViewController
        viewController = SimpleViewController()
        
        // Loading the View in the ViewController
        _ = viewController.view
    }
    
    override func tearDown() {
        viewController = nil
        super.tearDown()
    }
    
    func testUISetup() {
        // Checking if the elements are in the interface
        XCTAssertNotNil(viewController.firstTextField)
        XCTAssertNotNil(viewController.secondTextField)
        XCTAssertNotNil(viewController.resultLabel)
        XCTAssertNotNil(viewController.stackView)
        
        // Check ifthe fields and the label were added to the stackView
        XCTAssertTrue(viewController.stackView.arrangedSubviews.contains(viewController.firstTextField))
        XCTAssertTrue(viewController.stackView.arrangedSubviews.contains(viewController.secondTextField))
        XCTAssertTrue(viewController.stackView.arrangedSubviews.contains(viewController.resultLabel))
    }
    
    func testResultLabelUpdatesWithTextFields() {
        // Simulate an entry to the the first field
        viewController.firstTextField.text = "Hello"
        viewController.firstTextField.sendActions(for: .editingChanged)
        
        // Simulate an entry to the the second field
        viewController.secondTextField.text = "World"
        viewController.secondTextField.sendActions(for: .editingChanged)
        
        // Checking the result in the label
        XCTAssertEqual(viewController.resultLabel.text, "First: Hello\nSecond: World")
        
        // Simulate a new entry in the first field
        viewController.firstTextField.text = "Rx"
        viewController.firstTextField.sendActions(for: .editingChanged)
        
        // Simulate a new entry in the second field
        viewController.secondTextField.text = "Swift"
        viewController.secondTextField.sendActions(for: .editingChanged)
        
        // Checking the result in the label
        XCTAssertEqual(viewController.resultLabel.text, "First: Rx\nSecond: Swift")
    }
    
    func testEmptyTextFieldsResultLabel() {
        // Simulating empty fields
        viewController.firstTextField.text = ""
        viewController.firstTextField.sendActions(for: .editingChanged)
        
        viewController.secondTextField.text = ""
        viewController.secondTextField.sendActions(for: .editingChanged)
        
        // Checking the result in the label
        XCTAssertEqual(viewController.resultLabel.text, "First: \nSecond: ")
    }
    
    func testPartialInputInTextFields() {
        // Simulates partial input in text fields
        viewController.firstTextField.text = "Partial"
        viewController.firstTextField.sendActions(for: .editingChanged)
        
        viewController.secondTextField.text = ""
        viewController.secondTextField.sendActions(for: .editingChanged)
        
        // Checking the result in the label
        XCTAssertEqual(viewController.resultLabel.text, "First: Partial\nSecond: ")
    }
}

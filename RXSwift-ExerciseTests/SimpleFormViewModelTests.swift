//
//  SimpleFormViewModelTests.swift
//  RXSwift-Exercise
//
//  Created by Robson Cesar de Siqueira on 25/11/24.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest
import RxBlocking

@testable import RXSwift_Exercise

class SimpleFormViewModelTests: XCTestCase {
    
    var viewModel: SimpleFormViewModel!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        viewModel = SimpleFormViewModel()
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        viewModel = nil
        scheduler = nil
        disposeBag = nil
        super.tearDown()
    }
    
    func testIsSubmitButtonEnable_WhenFieldsAreEmpty_ShouldBeDisabled() {
        let isEnabled = try! viewModel.isSubmitButtonEnable
            .toBlocking(timeout: 1.0)
            .first()
        
        XCTAssertFalse(isEnabled ?? true)
    }
    
    func testIsSubmitButtonEnable_WhenFieldsAreFilled_ShouldBeEnabled() {
        viewModel.name.accept("John")
        viewModel.lastName.accept("Doe")
        
        let isEnabled = try! viewModel.isSubmitButtonEnable
            .toBlocking(timeout: 1.0)
            .first()
        
        XCTAssertTrue(isEnabled ?? false)
    }
    
    func testSubmitAction_WhenButtonTapped_ShouldPrintNameAndLastName() {
        viewModel.name.accept("Jane")
        viewModel.lastName.accept("Smith")
        
        let observer = scheduler.createObserver((String, String).self)
        
        viewModel.submitAction
            .withLatestFrom(Observable.combineLatest(viewModel.name, viewModel.lastName))
            .subscribe(observer)
            .disposed(by: disposeBag)
        
        viewModel.submitAction.onNext(())
        
        scheduler.start()
        
        let expectedEvents = [
            Recorded.next(0, ("Jane", "Smith"))
        ]
        
        XCTAssertEqual(observer.events.count, expectedEvents.count, "Wrong Events number")
        for (index, event) in observer.events.enumerated() {
            XCTAssertEqual(event.time, expectedEvents[index].time, "Wrong index: \(index).")
            XCTAssertEqual(event.value.element?.0, expectedEvents[index].value.element?.0, "Wrong first value \(index).")
            XCTAssertEqual(event.value.element?.1, expectedEvents[index].value.element?.1, "Wrong seccond value \(index).")
        }
    }
}

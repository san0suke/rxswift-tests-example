//
//  SimpleFormViewModel.swift
//  RXSwift-Exercise
//
//  Created by Robson Cesar de Siqueira on 24/11/24.
//

import UIKit
import RxSwift
import RxCocoa

class SimpleFormViewModel {
    
    let name = BehaviorRelay<String>(value: "")
    let lastName = BehaviorRelay<String>(value: "")
    let submitAction = PublishSubject<Void>()
    
    private let disposeBag = DisposeBag()
    
    var isSubmitButtonEnable: Observable<Bool> {
        return Observable
            .combineLatest(name, lastName) { name, lastName in
                return !name.isEmpty && !lastName.isEmpty
            }
    }
    
    init() {
        setupBindings()
    }
    
    private func setupBindings() {
        submitAction
            .withLatestFrom(Observable.combineLatest(name, lastName))
            .subscribe(onNext: { name, lastName in
                print(name)
                print(lastName)
            })
            .disposed(by: disposeBag)
    }
}

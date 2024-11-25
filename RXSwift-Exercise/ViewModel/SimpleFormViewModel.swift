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
    
    var isSubmitButtonEnable: Observable<Bool> {
        return Observable
            .combineLatest(name, lastName) { name, lastName in
                return !name.isEmpty && !lastName.isEmpty
            }
    }
}

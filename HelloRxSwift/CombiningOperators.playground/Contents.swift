import RxSwift
import UIKit

let disposeBag = DisposeBag()

func runStartWith() {
    let numbers = Observable.of(2, 3, 4)

    let observable = numbers.startWith(1)

    observable.subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)
}

// runStartWith()

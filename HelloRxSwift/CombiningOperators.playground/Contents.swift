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

func runConcat() {
    let first = Observable.of(1, 2, 3)
    let second = Observable.of(4, 5, 6)

    let observable = Observable.concat([first, second])

    observable.subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)
}

// runConcat()

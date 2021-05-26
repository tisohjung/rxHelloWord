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

func runMerge() {
    let left = PublishSubject<Int>()
    let right = PublishSubject<Int>()

    let source = Observable.of(left.asObservable(), right.asObservable())
    let observable = source.merge()
    observable.subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)

    left.onNext(1)
    left.onNext(2)
    right.onNext(4)
    right.onNext(5)
    left.onNext(3)
}

// runMerge()

func runCombineLatest() {
    let left = PublishSubject<Int>()
    let right = PublishSubject<Int>()

    let observable = Observable.combineLatest(left, right, resultSelector: { lastLeft, lastRight in
        "\(lastLeft) \(lastRight)"
    })

    let disposable = observable.subscribe(onNext: { value in
        print(value)
    })

    left.onNext(1)
    left.onNext(2)
    right.onNext(4)
    right.onNext(5)
    left.onNext(3)
}

// runCombineLatest()

func runWithLatestFrom() {
    let button = PublishSubject<Void>()
    let textField = PublishSubject<String>()

    let observable = button.withLatestFrom(textField)
    let disposable = observable.subscribe(onNext: {
        print($0)
    })

    textField.onNext("Sw")
    textField.onNext("Swi")
    textField.onNext("Swift")

    button.onNext(())
    button.onNext(())
}

// runWithLatestFrom()

func runReduce() {
    let source = Observable.of(1, 2, 3)

    source.reduce(0, accumulator: +)
        .subscribe(onNext: {
            print($0)
        }).disposed(by: disposeBag)

    source.reduce(0, accumulator: { summary, newValue in
        return summary + newValue
    }).subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)
}

// runReduce()

import PlaygroundSupport
import RxSwift
import UIKit

let disposeBag = DisposeBag()
let strikes = PublishSubject<String>()

/// IgnoreElements
func runIgnoreElements() {
    strikes.ignoreElements().subscribe({ _ in
        print("Subscription is called")
    }).disposed(by: disposeBag)

    strikes.onNext("A")
    strikes.onNext("B")
    strikes.onNext("C")
    strikes.onCompleted()
}

/// ElementAt
func runElementAt() {
    strikes.elementAt(2)
        .subscribe(onNext: { _ in
            print("You are out!")
        }).disposed(by: disposeBag)

    strikes.onNext("0")
    strikes.onNext("1")
    strikes.onNext("2")
}

/// Filter
func runFilter() {
    Observable.of(1, 2, 3, 4, 5, 6, 7)
        .filter({
            $0 % 2 == 0
        }).subscribe(onNext: {
            print($0)
        }).disposed(by: disposeBag)
}

/// Skip
func runSkip() {
    Observable.of("A", "B", "C", "D", "E", "F")
        .skip(3)
        .subscribe(onNext: {
            print($0)
        }).disposed(by: disposeBag)
}

/// SkipWhile
func runSkipWhile() {
    Observable.of(1, 2, 3, 4, 4)
        .skipWhile({ $0 < 3 })
        .subscribe(onNext: {
            print($0)
        }).disposed(by: disposeBag)
}

/// SkipUntil
func runSkipUntil() {
    let subject = PublishSubject<String>()
    let trigger = PublishSubject<String>()

    subject.skipUntil(trigger)
        .subscribe(onNext: {
            print($0)
        }).disposed(by: disposeBag)

    subject.onNext("A")
    subject.onNext("B")
    trigger.onNext("X")
    subject.onNext("C")
}

/// Take
func runTake() {
    Observable.of(1,2,3,4,5,6)
        .take(3)
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
}

/// TakeWhile
func runTakeWhile() {
    Observable.of(1,2,3,4,5,5,6,7)
        .takeWhile({ return $0 < 4 })
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
}

/// TakeUntil
func runTakeUntil() {
    let subject = PublishSubject<String>()
    let trigger = PublishSubject<String>()

    subject.takeUntil(trigger)
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)

    subject.onNext("1")
    subject.onNext("2")
    trigger.onNext("X")
    subject.onNext("3")
}

// runIgnoreElements()
// runElementAt()
// runFilter()
// runSkip()
//runSkipWhile()
//runSkipUntil()
//runTake()
//runTakeWhile()
//runTakeUntil()

import PlaygroundSupport
import RxCocoa
import RxSwift
import UIKit

/// 1 Observable
func runObservable() {
    _ = Observable.from([1, 2, 3, 4, 5])

    let observable = Observable.just(1)
    let observable2 = Observable.of(1, 2, 3)
    let observable3 = Observable.of([1, 2, 3])
    let observable4 = Observable.from([1, 2, 3, 4, 5])
    observable4.subscribe({ event in
        if let element = event.element {
            print(element)
        }
    })
    observable3.subscribe({ event in
        if let element = event.element {
            print(element)
        }
    })
    let subscription4 = observable4.subscribe(onNext: { element in
        print(element)
    })
    subscription4.dispose()
}

/// 2 DisposeBag
func runDisposeBag() {
    let disposeBag = DisposeBag()
    let ob = Observable.of("A", "B", "C").subscribe({
        print($0)
    }).disposed(by: disposeBag)
    Observable<String>.create { observer in
        observer.onNext("A")
        observer.onCompleted()
        observer.onNext("?")
        return Disposables.create()
    }.subscribe(onNext: { print($0) }, onError: { print($0) }, onCompleted: { print("complete") }, onDisposed: { print("disposed") }).disposed(by: disposeBag)
}

/// 3. PublishSubject

func runPublishSubject() {
    let disposeBag = DisposeBag()
    let subject = PublishSubject<String>()
    subject.onNext("Issue 1")
    subject.subscribe { event in
        print(event)
    }
    subject.onNext("Issue 2")
    subject.onNext("Issue 3")
    subject.dispose()
    subject.onCompleted() // can't be called after dispose
    subject.onNext("Issue 4") // can't be called after dispose or complete
}

/// 4 BehaviorSubject

func runBehaviorSubject() {
    let disposeBag = DisposeBag()
    let subject = BehaviorSubject(value: "Initial Value") // Prints out last value of the subject
    // subject.onNext("Issue 0")

    subject.subscribe({ event in
        print(event)
    })

    subject.onNext("Issue 1")
}

/// 6 Variable

func runVariable() {
    let disposeBag = DisposeBag()
    let variable = Variable([String]())
    variable.value.append("Item1")
    variable.asObservable().subscribe({ print($0) })
    variable.value.append("Item2")
}

/// 7 BehaviorRelay
func runBehaviorRelay() {
    let disposeBag = DisposeBag()
    let relay = BehaviorRelay(value: ["Initial Value"])
    relay.asObservable().subscribe({ print($0) })
    // relay.value = "Hello World" // value is get-only property
    // relay.accept(relay.value + ["Item 1"])
    var value = relay.value
    value.append("Item2")
    value.append("Item3")
    relay.accept(value)
}

runObservable()
print("----------------------------------------------------")
runDisposeBag()
print("----------------------------------------------------")
runPublishSubject()
print("----------------------------------------------------")
runBehaviorSubject()
print("----------------------------------------------------")
runVariable()
print("----------------------------------------------------")
runBehaviorRelay()

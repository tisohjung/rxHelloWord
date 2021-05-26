import PlaygroundSupport
import RxSwift
import UIKit

let disposeBag = DisposeBag()

func runToArray() {
    Observable.of(1, 2, 3, 4, 5)
        .toArray()
        .subscribe({
            print($0)
        }).disposed(by: disposeBag)
}

//runToArray()

func runMap() {
    Observable.of(1, 2, 3, 4, 5)
        .map({
            return $0 * 2
        }).subscribe(onNext: {
            print($0)
        }).disposed(by: disposeBag)
}

runMap()

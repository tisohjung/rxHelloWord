import PlaygroundSupport
import RxSwift
import RxCocoa

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

//runMap()

func runFlatMap() {
    struct Student {
        var score: BehaviorRelay<Int>
    }

    let john = Student(score: BehaviorRelay(value: 95))
    let mary = Student(score: BehaviorRelay(value: 85))

    let student = PublishSubject<Student>()

    student.asObservable()
        .flatMap({ $0.score.asObservable() })
        .subscribe(onNext: {
            print($0)
        }).disposed(by: disposeBag)

    student.onNext(john)
//    john.score.value = 100
    john.score.accept(100)

    student.onNext(mary)
    mary.score.accept(100)
    john.score.accept(44)
}

runFlatMap()



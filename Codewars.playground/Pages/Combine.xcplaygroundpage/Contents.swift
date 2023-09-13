//: [Previous](@previous)

import Foundation
import Combine

enum WeatherError: Error {
    case someError
}

let weatherPublisher = PassthroughSubject<Int, WeatherError>()
let subscriber = weatherPublisher
    .filter { $0 > 25 }
    .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
            print("Error: \(error)")
        case .finished:
            print("Finished")
        }
    }, receiveValue: { value in
        print(value)
    })

weatherPublisher.send(10)
weatherPublisher.send(20)
weatherPublisher.send(30)
weatherPublisher.send(40)
//weatherPublisher.send(completion: .failure(WeatherError.someError))
weatherPublisher.send(50)
weatherPublisher.send(completion: .finished)
weatherPublisher.send(60)


// AnyCancellable == disposedBag
//: [Next](@next)

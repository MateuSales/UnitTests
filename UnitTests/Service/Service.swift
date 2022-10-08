import Foundation

enum CustomError: Error {
    case someError
}

protocol Servicing {
    func getData(completion: @escaping (Result<Model, CustomError>) -> Void)
}

final class Service: Servicing {
    func getData(completion: @escaping (Result<Model, CustomError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completion(.success(.init(name: "Mateus Sales")))
        }
    }
}

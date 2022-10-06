struct Model {
    let name: String
}

enum CustomError: Error {
    case someError
}


protocol Servicing {
    func getData(completion: @escaping (Result<Model, CustomError>) -> Void)
}

final class Service: Servicing {
    func getData(completion: @escaping (Result<Model, CustomError>) -> Void) {
        // URL Session / Alamofire ou qualquer outra coisa
    }
}

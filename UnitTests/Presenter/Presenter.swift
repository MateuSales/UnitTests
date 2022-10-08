protocol Presenting {
    func loadInitialState()
}

protocol PresenterDelegate: AnyObject {
    func display(_ name: String)
    func showLoading()
    func hideLoading()
    func showError(title: String, message: String)
}

final class Presenter: Presenting {
    private let service: Servicing
    weak var delegate: PresenterDelegate?
    
    init(service: Servicing) {
        self.service = service
    }
    
    func loadInitialState() {
        delegate?.showLoading()
        service.getData { [weak self] result in
            self?.delegate?.hideLoading()
            switch result {
            case let .success(model):
                self?.delegate?.display(model.name)
            case .failure:
                self?.delegate?.showError(
                    title: "Tivemos um erro :(",
                    message: "Tente novamente mais tarde."
                )
            }
        }
    }
}

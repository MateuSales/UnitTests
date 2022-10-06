import UIKit

enum Factory {
    static func make() -> UIViewController {
        let service = Service()
        let presenter = Presenter(service: service)
        let viewController = ViewController(presenter: presenter)
        
        presenter.delegate = viewController
        
        return viewController
    }
}

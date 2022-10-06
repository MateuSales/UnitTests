import XCTest
@testable import UnitTests

final class PresenterTests: XCTestCase {

    func test_loadInitialState_whenRequestFails_shouldCallDelegateCorrectly() {
        let (sut, doubles) = makeSUT()
        
        sut.loadInitialState()
        doubles.serviceSpy.complete(with: .failure(.someError))
        
        XCTAssertEqual(doubles.delegateSpy.receivedMessages, [.showLoading, .hideLoading, .showError])
    }
    
    func test_loadInitialState_whenRequestIsSuccess_shouldCallDelegateCorrectly() {
        let (sut, doubles) = makeSUT()
        
        sut.loadInitialState()
        doubles.serviceSpy.complete(with: .success(.init(name: "Mateus")))
        
        XCTAssertEqual(doubles.delegateSpy.receivedMessages, [.showLoading, .hideLoading, .display("Mateus")])
    }
    
    // MARK: Helpers
    
    private typealias SutAndDoubles = (
        sut: Presenter,
        doubles: (
            serviceSpy: ServicingSpy,
            delegateSpy: PresenterDelegateSpy
        )
    )
    
    private func makeSUT() -> SutAndDoubles {
        let serviceSpy = ServicingSpy()
        let delegateSpy = PresenterDelegateSpy()
        let sut = Presenter(service: serviceSpy)
        sut.delegate = delegateSpy
        
        return (sut, (serviceSpy, delegateSpy))
    }
    
    private class ServicingSpy: Servicing {
        private(set) var receivedMessages: [(Result<Model, CustomError>) -> Void] = []
        
        func getData(completion: @escaping (Result<Model, CustomError>) -> Void) {
            receivedMessages.append(completion)
        }
        
        func complete(with result: Result<Model, CustomError>, at index: Int = 0) {
            receivedMessages[index](result)
        }
    }
    
    private class PresenterDelegateSpy: PresenterDelegate {
        enum Message: Equatable, CustomStringConvertible {
            case display(String)
            case showLoading
            case hideLoading
            case showError
            
            var description: String {
                switch self {
                case .showError:
                    return "showError"
                case .display(let name):
                    return "display - \(name)"
                case .showLoading:
                    return "showLoading"
                case .hideLoading:
                    return "hideLoading"
                }
            }
        }
        
        private(set) var receivedMessages: [Message] = []

        func display(_ name: String) {
            receivedMessages.append(.display(name))
        }
        
        func showLoading() {
            receivedMessages.append(.showLoading)
        }
        
        func hideLoading() {
            receivedMessages.append(.hideLoading)
        }
        
        func showError() {
            receivedMessages.append(.showError)
        }
    }
}

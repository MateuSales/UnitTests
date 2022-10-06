//
//  ViewController.swift
//  UnitTests
//
//  Created by user on 06/10/22.
//

import UIKit

class ViewController: UIViewController {
    private let presenter: Presenting
    
    init(presenter: Presenting) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
}

extension ViewController: PresenterDelegate {
    func display(_ name: String) { }
    
    func showError() { }
    
    func hideLoading() { }

    func showLoading() { }
}

//
//  ViewController.swift
//  UnitTests
//
//  Created by user on 06/10/22.
//

import UIKit

class ViewController: UIViewController, AlertPresentable {
    private let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .darkGray
        return view
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    private let presenter: Presenting
    
    init(presenter: Presenting) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aditionalSetup()
        addViewsInHierarchy()
        setupConstraints()
        
        presenter.loadInitialState()
    }
}

// MARK: - Layout

private extension ViewController {
    func aditionalSetup() {
        view.backgroundColor = .white
    }
    
    func addViewsInHierarchy() {
        view.addSubview(nameLabel)
        view.addSubview(activityIndicator)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

extension ViewController: PresenterDelegate {
    func display(_ name: String) {
        nameLabel.text = name
    }
    
    func showError(title: String, message: String) {
        showAlert(title: title, message: message)
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
    }

    func showLoading() {
        activityIndicator.startAnimating()
    }
}

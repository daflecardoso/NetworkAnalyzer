//
//  ViewController.swift
//  NetworkAnalyzer
//
//  Created by daflecardoso on 09/28/2021.
//  Copyright (c) 2021 daflecardoso. All rights reserved.
//

import UIKit
import NetworkAnalyzer

class ViewController: UIViewController {
    
    private lazy var showButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show network area", for: .normal)
        button.backgroundColor = .systemBlue
        button.contentEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
        button.layer.cornerRadius = 8
        button.setTitleColor(.white.withAlphaComponent(0.5), for: .highlighted)
        button.addTarget(self, action: #selector(didTapShowNetworkArea), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        inserEvent()
    
        setup()
    }
    
    private func inserEvent() {
        let baseUrl = "https://api.something.com"
        let path = "/some/path"
        let headers = "\"Authorization\": \"Bearer 31cah32....\""
        let query = "some=data&something=anotherData"
        let requestBody = "{\"firstName\": \"Network\" }"
        let response = "{\"lasName\": \"Analyzer\" }"
        
        let event = NetworkAnalyzerData(baseUrl: baseUrl,
                                        method: "GET",
                                        path: path,
                                        absoluteUrl: baseUrl + path,
                                        headers: headers,
                                        query: query,
                                        requestBody: requestBody,
                                        statusCode: 200,
                                        response: response,
                                        date: Date())
        NetworkAnalyzer.shared.insert(event: event)
    }
    
    private func setup() {
        view.addSubview(showButton)
        
        NSLayoutConstraint.activate([
            showButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    @objc private func didTapShowNetworkArea() {
        let controller = NetworkAnalyzer.shared.makeNetworkAnalyzerViewController()
        let navigation = UINavigationController(rootViewController: controller)
        present(navigation, animated: true, completion: nil)
    }
}


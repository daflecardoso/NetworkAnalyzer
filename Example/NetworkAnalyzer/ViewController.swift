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
        view.backgroundColor = .backgroundContainerViews
        inserEvent()
    
        setup()
    }
    
    private func inserEvent() {
        let baseUrl = "https://api.something.com"
        let path = "/some/path"
        let headers = """
{
    "Authorization" : "Bearer d//eq324..."
}
"""
        let query = "some=data&something=anotherData"
        let requestBody = """
{
    "firstName" : "Netowork"
}
"""
        let response = """
{
  "vehicles" : [
    {
      "userId" : 24,
      "cdnKey" : null,
      "id" : 8,
      "plate" : "NYP2929",
      "ownerDocument" : "43070806880",
      "imageUrl" : null,
      "renavam" : "12345678999",
      "updatedAt" : "2021-07-04T21:19:50.000Z",
      "createdAt" : "2021-04-12T23:29:54.000Z",
      "name" : "Mock 2 307"
    },
    {
      "userId" : 24,
      "cdnKey" : null,
      "id" : 13,
      "plate" : "NYP2929",
      "ownerDocument" : "",
      "imageUrl" : null,
      "renavam" : "",
      "updatedAt" : "2021-04-26T00:54:45.000Z",
      "createdAt" : "2021-04-26T00:54:45.000Z",
      "name" : "Mock C4"
    },
    {
      "userId" : 25,
      "cdnKey" : null,
      "id" : 13,
      "plate" : "NYP2929",
      "ownerDocument" : "",
      "imageUrl" : null,
      "renavam" : "",
      "updatedAt" : "2021-04-26T00:54:45.000Z",
      "createdAt" : "2021-04-26T00:54:45.000Z",
      "name" : "Mock C4"
    }
  ]
}
"""
        
        let pathFile = Bundle.main.path(forResource: "home", ofType: "json") ?? ""
        let data = try? Data(contentsOf: URL(fileURLWithPath: pathFile))
        let json = String(data: data ?? Data(), encoding: .utf8) ?? ""
        
    //    print(json)
        
        let event = NetworkAnalyzerData(baseUrl: baseUrl,
                                        method: "GET",
                                        path: path,
                                        absoluteUrl: baseUrl + path,
                                        headers: headers,
                                        query: query,
                                        requestBody: requestBody,
                                        statusCode: 200,
                                        response: json,
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


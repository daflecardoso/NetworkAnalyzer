//
//  JSONEditorViewController.swift
//  NetworkAnalyzer
//
//  Created by Dafle on 06/10/21.
//

import Foundation
import UIKit
import WebKit

class JSONEditorViewController: UIViewController {
    
    private let networkAnalyzer: NetworkAnalyzerData
    
    init(networkAnalyzer: NetworkAnalyzerData) {
        self.networkAnalyzer = networkAnalyzer
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let preferences = WKPreferences().apply {
        $0.javaScriptEnabled = true
    }
 
    lazy var configuration = WKWebViewConfiguration().apply {
        $0.preferences = preferences
    }
    
    lazy var webView = WKWebView(frame: .zero, configuration: configuration).apply {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupView()
        setupConstraints()
        setupWebView()
    }
    
    private func setupView() {
        view.backgroundColor = .backgroundContainerViews
    }
    
    private func setupConstraints() {
        view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }
    
    private func makeHTML() {
        
    }
    
    private func setupWebView() {
        let html = """
<!doctype html>
<html lang="">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title></title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel=stylesheet href=https://cdn.jsdelivr.net/npm/pretty-print-json@1.1/dist/pretty-print-json.css>
</head>
<body>
<p>Hello world! This is HTML5 Boilerplate.</p>
<pre id=account></pre>

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src=https://cdn.jsdelivr.net/npm/pretty-print-json@1.1/dist/pretty-print-json.min.js></script>

<script>

            const data = \(networkAnalyzer.response)
            const elem = document.getElementById('account');
            elem.innerHTML = prettyPrintJson.toHtml(data);

</script>
</body>
</html>

  
"""
        webView.loadHTMLString(html, baseURL: nil)
    }
}

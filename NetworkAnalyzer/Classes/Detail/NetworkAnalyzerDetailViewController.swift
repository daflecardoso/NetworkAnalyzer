//
//  NetworkAnalyzerDetailViewController.swift
//  iCar
//
//  Created by Dafle Cardoso on 23/04/21.
//  Copyright © 2021 Dafle Cardoso. All rights reserved.
//

import Foundation
import UIKit
import WebKit

enum SegmentRequestOptions: Int, CaseIterable {
    case header, query, request, response
    
    var title: String {
        switch self {
        case .header:
            return "Headers"
        case .query:
            return "Query"
        case .request:
            return "Request"
        case .response:
            return "Response"
            
        }
    }
}

class NetworkAnalyzerDetailViewController: UIViewController {
    
    private let margin: CGFloat = 16
    
    private lazy var activityIndicator = UIActivityIndicatorView().apply {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.startAnimating()
        $0.isHidden = true
    }
    
    private lazy var stackUrlStatus: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            UILabel().apply { label in
                label.font = .medium(14)
                label.numberOfLines = 0
                label.text = viewModel.networkAnalyzer.absoluteUrl
                label.textColor = .blueBlue
            }
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmented = UISegmentedControl()
        segmented.translatesAutoresizingMaskIntoConstraints = false
        SegmentRequestOptions.allCases.forEach { item in
            segmented.insertSegment(withTitle: item.title, at: item.rawValue, animated: true)
        }
        segmented.addTarget(self, action: #selector(didChangeSegmented), for: .valueChanged)
        return segmented
    }()
    
    let preferences = WKPreferences().apply {
        $0.javaScriptEnabled = true
    }
    
    lazy var configuration = WKWebViewConfiguration().apply {
        $0.preferences = preferences
    }
    
    lazy var webView = WKWebView(frame: .zero, configuration: configuration).apply {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
    }
    
    private lazy var textView = UITextView().apply {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isEditable = false
        $0.font = .menlo(14)
        $0.backgroundColor = .clear
    }
    
    private let native: Bool = true
    
    private lazy var rootView: UIView = {
        return native ? textView : webView
    }()
    
    private let viewModel: NetworkAnalyzerDetailViewModel
    
    init(viewModel: NetworkAnalyzerDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupSegmentedControl()
        
        //        let bbb = humanReadableByteCount(bytes: viewModel.networkAnalyzer.response.utf8.count)
        //        print("bbb", bbb)
    }
    
    func humanReadableByteCount(bytes: Int) -> String {
        if (bytes < 1000) { return "\(bytes) B" }
        let exp = Int(log2(Double(bytes)) / log2(1000.0))
        let unit = ["KB", "MB", "GB", "TB", "PB", "EB"][exp - 1]
        let number = Double(bytes) / pow(1000, Double(exp))
        if exp <= 1 || number >= 100 {
            return String(format: "%.0f %@", number, unit)
        } else {
            return String(format: "%.1f %@", number, unit)
                .replacingOccurrences(of: ".0", with: "")
        }
    }
    
    private func setupView() {
        view.backgroundColor = .backgroundContainerViews
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
        navigationItem.titleView = UIStackView(arrangedSubviews: [
            UILabel().apply { label in
                label.font = .bold(14)
                label.text = viewModel.networkAnalyzer.method
                label.textColor = viewModel.networkAnalyzer.methodColor
            },
            UILabel().apply { label in
                label.font = .regular(14)
                label.text = String(viewModel.networkAnalyzer.statusCode)
                label.textColor = viewModel.networkAnalyzer.statusCodeColor
            }
        ]).apply {
            $0.axis = .horizontal
            $0.spacing = 8
        }
    }
    
    @objc private func didTapShare() {
        let text = viewModel.makeLogText()
        let shareAll = [text]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    private func setupConstraints() {
        view.addSubview(activityIndicator)
        view.addSubview(stackUrlStatus)
        view.addSubview(rootView)
        view.addSubview(segmentedControl)
        
        NSLayoutConstraint.activate([
            
            stackUrlStatus.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: margin),
            stackUrlStatus.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: margin),
            stackUrlStatus.trailingAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -margin),
            
            segmentedControl
                .topAnchor.constraint(equalTo: stackUrlStatus.safeAreaLayoutGuide.bottomAnchor, constant: margin),
            segmentedControl
                .leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: margin),
            segmentedControl
                .trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -margin),
            
            rootView.topAnchor.constraint(equalTo: segmentedControl.safeAreaLayoutGuide.bottomAnchor),
            rootView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            rootView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            rootView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupSegmentedControl() {
        segmentedControl.selectedSegmentIndex = 0
        didChangeSegmented(segmentedControl)
    }
    
    
    @objc private func didChangeSegmented(_ sender: UISegmentedControl) {
        guard let option = SegmentRequestOptions(rawValue: sender.selectedSegmentIndex) else {
            return
        }
        
        let start = DispatchTime.now()
        textView.attributedText = viewModel.prettyText(type: option).makeJsonAttributedV2()
        let end = DispatchTime.now()
        
        let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds // <<<<< Difference in nano seconds (UInt64)
        let timeInterval = Double(nanoTime) / 1_000_000_000 // Technically could overflow for long running tests
        
        print("Time to evaluate problem \(option.title): \(timeInterval) seconds")
        
        let contents = viewModel.makeHTML(type: option)
        webView.loadHTMLString(contents, baseURL: nil)
        //        let html = viewModel.makeHTML(type: option)
        //        webView.loadHTMLString(html, baseURL: nil)
    }
}

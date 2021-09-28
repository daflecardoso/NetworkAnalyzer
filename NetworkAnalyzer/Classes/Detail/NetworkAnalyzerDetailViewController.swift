//
//  NetworkAnalyzerDetailViewController.swift
//  iCar
//
//  Created by Dafle Cardoso on 23/04/21.
//  Copyright © 2021 Dafle Cardoso. All rights reserved.
//

import Foundation
import UIKit

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
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let font: UIFont = .regular(16)
    
    private lazy var linesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 5000
        label.textColor = UIColor(red: 93/255, green: 114/255, blue: 166/255, alpha: 1.0)
        label.font = font
        return label
    }()
    
    private lazy var labelJson: SRCopyableLabel = {
        let label = SRCopyableLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 5000
        label.isUserInteractionEnabled = true
        label.font = font
        return label
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

    private func setupConstraints() {
        view.addSubview(stackUrlStatus)
        view.addSubview(scrollView)
        view.addSubview(segmentedControl)
        scrollView.addSubview(labelJson)
        scrollView.addSubview(linesLabel)
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
            
            scrollView.topAnchor
                .constraint(equalTo: segmentedControl.safeAreaLayoutGuide.bottomAnchor, constant: margin),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            linesLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            linesLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
            linesLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            labelJson.topAnchor.constraint(equalTo: scrollView.topAnchor),
            labelJson.leadingAnchor.constraint(equalTo: linesLabel.trailingAnchor, constant: 10),
            labelJson.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            labelJson.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
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
        self.linesLabel.text = viewModel.makeLines(for: option)
        labelJson.attributedText = viewModel.text(for: option).makeJsonAttributed()
    }
}

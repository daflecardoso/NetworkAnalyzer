//
//  NetworkAnalyzerCell.swift
//  iCar
//
//  Created by Dafle Cardoso on 23/04/21.
//  Copyright © 2021 Dafle Cardoso. All rights reserved.
//

import Foundation
import UIKit

class NetworkAnalyzerCell: UITableViewCell {

    private let margin: CGFloat = 16
    
    private let methodLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .bold(16)
        label.layer.masksToBounds = true
        label.numberOfLines = 0
        return label
    }()
    
    private let baseUrlLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .medium(14)
        label.numberOfLines = 0
        return label
    }()

    private let statusCodeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .bold(14)
        label.numberOfLines = 0
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .regular(12)
        label.numberOfLines = 0
        label.textColor = .warmGrey
        label.textAlignment = .right
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            methodLabel,
            baseUrlLabel,
            statusCodeLabel,
            timeLabel
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.distribution = .fill
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupContentView()
        setupConstraints()
    }
    
    private func setupContentView() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    private func setupConstraints() {
        contentView.addSubview(stackView)
        
        contentView.addConstraints([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: margin),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: margin),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -margin)
        ])
    }

    func set(with item: NetworkAnalyzerData) {
        methodLabel.text = item.method
        methodLabel.textColor = item.methodColor
        baseUrlLabel.text = item.absoluteUrl
        statusCodeLabel.text = String(item.statusCode)
        statusCodeLabel.textColor = item.statusCodeColor
        timeLabel.text = item.date.string("EEEE, MMMM dd yyyy HH:mm:ss")
    }
}

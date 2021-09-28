//
//  NetworkAnalyzerDetailViewModel.swift
//  iCar
//
//  Created by Dafle Cardoso on 23/04/21.
//  Copyright © 2021 Dafle Cardoso. All rights reserved.
//

import Foundation

class NetworkAnalyzerDetailViewModel {
    
    internal let networkAnalyzer: NetworkAnalyzerData
    
    init(networkAnalyzer: NetworkAnalyzerData) {
        self.networkAnalyzer = networkAnalyzer
    }
    
    func text(for type: SegmentRequestOptions) -> String {
        switch type {
        case .header:
            return networkAnalyzer.headers
        case .request:
            return networkAnalyzer.requestBody
        case .response:
            return networkAnalyzer.response
        case .query:
            return networkAnalyzer.query
        }
    }
    
    func makeLines(for type: SegmentRequestOptions) -> String {
        var textFinal = ""
        text(for: type).components(separatedBy: "\n").enumerated().forEach { index, _ in
            textFinal.append("\(index + 1)\n")
        }
        return textFinal
    }
}

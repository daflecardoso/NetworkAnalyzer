//
//  NetworkAnalyzer.swift
//  NetworkAnalyzer
//
//  Created by Dafle on 28/09/21.
//

import Foundation
import UIKit

public class NetworkAnalyzer {
    
    static let bundle: Bundle = {
        let bundleName = "NetworkAnalyzer"
        let bundle = Bundle(for: NetworkAnalyzer.self)
        
        guard let resourceBundleURL = bundle.url(forResource: bundleName, withExtension: "bundle") else {
            return Bundle.main
        }
        
        guard let resourceBundle = Bundle(url: resourceBundleURL) else {
            return Bundle.main
        }
        
        return resourceBundle
    }()
    
    private let cache: Cache = Cache.shared
    
    public static let shared = NetworkAnalyzer()
    
    init() { }
    
    public func insert(event: NetworkAnalyzerData) {
        let events: [NetworkAnalyzerData] = Cache.shared.get(forKey: .networkEvents) ?? []
        cache.set([event] + events , forKey: .networkEvents)
    }
    
    public func makeNetworkAnalyzerViewController() -> NetworkAnalyzerViewController {
        let viewModel = NetworkAnalyzerViewModel()
        return NetworkAnalyzerViewController(viewModel: viewModel)
    }
}

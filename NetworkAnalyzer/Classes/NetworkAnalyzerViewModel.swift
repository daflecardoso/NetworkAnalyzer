//
//  NetworkAnalyzerViewModel.swift
//  iCar
//
//  Created by Dafle Cardoso on 23/04/21.
//  Copyright © 2021 Dafle Cardoso. All rights reserved.
//

import Foundation

public class NetworkAnalyzerViewModel {
    
    var onFetched: (() -> Void)?
    internal var loading: ((Bool) -> Void)?
    
    private(set) var items: [NetworkAnalyzerData] = []
    
    func fetch() {
        loading?(true)
        DispatchQueue.global(qos: .background).async { [unowned self] in
            let events: [NetworkAnalyzerData]? = Cache.shared.get(forKey: .networkEvents)
            self.items = events ?? []
            DispatchQueue.main.async {
                loading?(false)
                self.onFetched?()
            }
        }
    }
    
    func cleanHistory() {
        Cache.shared.remove(forKey: .networkEvents)
        fetch()
    }
}

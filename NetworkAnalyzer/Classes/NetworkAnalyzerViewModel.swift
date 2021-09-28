//
//  NetworkAnalyzerViewModel.swift
//  iCar
//
//  Created by Dafle Cardoso on 23/04/21.
//  Copyright © 2021 Dafle Cardoso. All rights reserved.
//

import Foundation

public class NetworkAnalyzerViewModel {
    
    var items: [NetworkAnalyzerData] {
        let events: [NetworkAnalyzerData]? = Cache.shared.get(forKey: .networkEvents)
        return events ?? []
    }
    
    func cleanHistory() {
        Cache.shared.remove(forKey: .networkEvents)
    }
}

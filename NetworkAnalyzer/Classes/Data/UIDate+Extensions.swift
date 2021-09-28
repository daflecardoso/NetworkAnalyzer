//
//  UIDate+Extensions.swift
//  NetworkAnalyzer
//
//  Created by Dafle on 28/09/21.
//

import Foundation
import UIKit

extension Date {
    
    func string(_ format: String) -> String {
        return DateFormatter().run { df in
            df.locale = Locale(identifier: "pt_BR")
            df.dateFormat = format
            return df.string(from: self)
        }
    }
    
    func timeBetween(to date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute], from: self, to: date)
        return components.minute ?? 0
    }
}

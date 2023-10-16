//
//  Data+Extension.swift
//  NetworkAnalyzer
//
//  Created by Dafle on 06/10/21.
//

import Foundation

extension Data {
    
    var isValidJson: Bool {
        do {
            _ = try JSONSerialization.jsonObject(with: self, options: [])
            return true
        } catch {
            return false
        }
    }
    
    var prettyPrintedJSONString: String? {
        let options: JSONSerialization.WritingOptions
        if #available(iOS 13.0, *) {
            options = [.prettyPrinted, .withoutEscapingSlashes]
        } else {
            options = [.prettyPrinted]
        }
        
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []) else {
            return nil
        }
        
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: options) else {
            return nil
        }
        
        guard let prettyPrintedString = String(data: data, encoding: .utf8) else {
            return nil
        }

        return prettyPrintedString
    }
}

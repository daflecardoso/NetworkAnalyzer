//
//  String+Extension.swift
//  NetworkAnalyzer
//
//  Created by Dafle on 28/09/21.
//

import Foundation
import UIKit

extension String {
    
    public func capturedGroups(withRegex pattern: String) -> [String] {
        var results = [String]()
        
        var regex: NSRegularExpression
        do {
            regex = try NSRegularExpression(pattern: pattern, options: [])
        } catch {
            return results
        }
        
        let matches = regex.matches(in: self, options: [], range: NSRange(location:0, length: self.count))
        
        guard let match = matches.first else { return results }
        
        let lastRangeIndex = match.numberOfRanges - 1
        guard lastRangeIndex >= 1 else { return results }
        
        for index in 1...lastRangeIndex {
            let capturedGroupIndex = match.range(at: index)
            let matchedString = (self as NSString).substring(with: capturedGroupIndex)
            results.append(matchedString)
        }
        
        return results
    }
    
    func matches(for regex: String) -> [String] {
        let text = self
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    struct JsonAttributedTheme {
        let stringColor: UIColor
        let keyJsonColor: UIColor
        let nullColor: UIColor
        let numberColor: UIColor
        let boolColor: UIColor
        
        static var `default`: JsonAttributedTheme {
            return .init(stringColor: UIColor(red: 254/255, green: 129/255, blue: 115/255, alpha: 1.0),
                         keyJsonColor: UIColor(red: 150/255, green: 136/255, blue: 248/255, alpha: 1.0),
                         nullColor: UIColor(red: 252/255, green: 122/255, blue: 175/255, alpha: 1.0),
                         numberColor: UIColor(red: 216/255, green: 198/255, blue: 129/255, alpha: 1.0),
                         boolColor: UIColor(red: 216/255, green: 187/255, blue: 252/255, alpha: 1.0))
        }
    }
    
    func makeJsonAttributed(theme: JsonAttributedTheme = .default) -> NSMutableAttributedString {
        let final = NSMutableAttributedString(string: "")
        
        self.components(separatedBy: "\n").forEach { pieceJson in
            
            let keyJsonGroups = pieceJson.matches(for: "\"[A-z0-9-]{1,}\"\\s:\\s")
            let nullGroups = pieceJson.capturedGroups(withRegex: "(null,)")
            let numberGroups = pieceJson.capturedGroups(withRegex: "([0-9.]{1,},)")
            let stringGroups = pieceJson.capturedGroups(withRegex: "(\\s\"[A-ú0-9!@#$%^&*()=\\s+\\-,.?\"://{}|<>]{1,}\")")
            let boolGroups = pieceJson.capturedGroups(withRegex: "(true,|false,)")
            
            let attributedString = NSMutableAttributedString(string: pieceJson, attributes: [
                .foregroundColor: UIColor.whiteBlackNavigationTint,
                .font: UIFont.regular(16)
            ])
            stringGroups.forEach { text in
                let range = (pieceJson as NSString).range(of: text)
                attributedString.addAttribute(.foregroundColor, value: theme.stringColor, range: range)
            }
            keyJsonGroups.forEach { text in
                let range = (pieceJson as NSString).range(of: text)
                attributedString.addAttribute(.foregroundColor, value: theme.keyJsonColor, range: range)
            }
            nullGroups.forEach { text in
                let range = (pieceJson as NSString).range(of: text)
                attributedString.addAttribute(.foregroundColor, value: theme.nullColor, range: range)
            }
            numberGroups.forEach { text in
                let range = (pieceJson as NSString).range(of: text)
                attributedString.addAttribute(.foregroundColor, value: theme.numberColor, range: range)
            }
            boolGroups.forEach { text in
                let range = (pieceJson as NSString).range(of: text)
                attributedString.addAttribute(.foregroundColor, value: theme.boolColor, range: range)
            }
            final.append(attributedString)
            final.append(NSAttributedString(string: "\n"))
        }
        
        return final
    }
    
    func makeJsonAttributedV2(theme: JsonAttributedTheme = .default) -> NSMutableAttributedString {
        let final = NSMutableAttributedString(string: "")
        
        var num = 0
        
        self.components(separatedBy: "\n").forEach { pieceJson in
            
            num = num + 1
            
            let keyJsonGroups = pieceJson.capturedGroups(withRegex: "(\"[A-ú0-9-]{1,}\"\\s:\\s)")
//            let nullGroups = pieceJson.capturedGroups(withRegex: "(null,|null)")
//            let numberGroups = pieceJson.capturedGroups(withRegex: "([0-9.]{1,},|[0-9.]{1,})")
//            let stringGroups = pieceJson.capturedGroups(withRegex: "(\\s\"[A-ú0-9!@#$%^&*()=\\s+\\-,.?\"://{}|<>]{1,}\")")
//            let boolGroups = pieceJson.capturedGroups(withRegex: "(true,|false,)")
            
//
//            let keyJsonGroups = pieceJson.matches(for: "(\"[A-ú0-9-]{1,}\"\\s:\\s)")
//            let nullGroups = pieceJson.matches(for: "(null,|null)")
//            let numberGroups = pieceJson.matches(for: "([0-9.]{1,},)")
//            let stringGroups = pieceJson.matches(for: "(\\s\"[A-ú0-9!@#$%^&*()=\\s+\\-,.?\"://{}|<>]{1,}\")")
//            let boolGroups = pieceJson.matches(for: "(true,|false,)")
//
            let attributedString = NSMutableAttributedString(string: pieceJson, attributes: [
                .foregroundColor: UIColor.whiteBlackNavigationTint,
                .font: UIFont.menlo(14)
            ])
//            numberGroups.forEach { text in
//                num = num + 1
//                let range = (pieceJson as NSString).range(of: text)
//                attributedString.addAttribute(.foregroundColor, value: theme.numberColor, range: range)
//            }
//            stringGroups.forEach { text in
//                num = num + 1
//                let range = (pieceJson as NSString).range(of: text)
//                attributedString.addAttribute(.foregroundColor, value: theme.stringColor, range: range)
//            }
            keyJsonGroups.forEach { text in
                num = num + 1
                let range = (pieceJson as NSString).range(of: text)
                attributedString.addAttribute(.foregroundColor, value: theme.keyJsonColor, range: range)
            }
//            nullGroups.forEach { text in
//                num = num + 1
//                let range = (pieceJson as NSString).range(of: text)
//                attributedString.addAttribute(.foregroundColor, value: theme.nullColor, range: range)
//            }
//
//            boolGroups.forEach { text in
//                num = num + 1
//                let range = (pieceJson as NSString).range(of: text)
//                attributedString.addAttribute(.foregroundColor, value: theme.boolColor, range: range)
//            }
            final.append(attributedString)
            final.append(NSAttributedString(string: "\n"))
        }
        
        print("num", num)
        return final
    }
}

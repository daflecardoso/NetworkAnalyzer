//
//  UILabel+Extension.swift
//  NetworkAnalyzer
//
//  Created by Dafle on 28/09/21.
//

import Foundation
import UIKit

extension UILabel {
    
    class func title(_ title: String) -> UILabel {
        return UILabel().apply { label in
            label.text = title
            label.font = .bold(18)
        }
    }
    
    func bold(in pieces: [String], font: UIFont = .medium(25)) {
        let text = self.text ?? ""
        self.attributedText = NSMutableAttributedString(string: text).apply(closure: { attributed in
            pieces.forEach { boldTitle in
                let range = (text as NSString).range(of: boldTitle)
                attributed.addAttribute(.font, value: font, range: range)
            }
        })
    }
}

//
//  UIColor+Extensions.swift
//  NetworkAnalyzer
//
//  Created by Dafle on 28/09/21.
//

import Foundation

extension UIColor {
    
    public static var backgroundContainerViews: UIColor = {
        let dark = UIColor(red: 17/255, green: 18/255, blue: 19/255, alpha: 1.0)
        
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    return dark
                } else {
                    return .white
                }
            }
        } else {
            return .white
        }
    }()
    
    public static var whiteBlackNavigationTint: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    return .white
                } else {
                    return .black
                }
            }
        } else {
            return .black
        }
    }()
    
    static let blueBlue = UIColor.systemBlue
    
    static let warmGrey = UIColor.lightGray
}

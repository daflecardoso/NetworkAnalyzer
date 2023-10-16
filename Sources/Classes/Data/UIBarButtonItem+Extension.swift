//
//  UIBarButtonItem+Extension.swift
//  NetworkAnalyzer
//
//  Created by Dafle on 28/09/21.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    
    class func delete(target: Any, selector: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .custom).apply { button in
            let image = UIImage(named: "ic_delete_navigation", in: NetworkAnalyzer.bundle, compatibleWith: nil)
            button.setImage(image, for: .normal)
            button.addTarget(target, action: selector, for: .touchUpInside)
        }
        return UIBarButtonItem(customView: button).apply { barbutton in
            barbutton.customView?.widthAnchor.constraint(equalToConstant: 20).isActive = true
            barbutton.customView?.heightAnchor.constraint(equalToConstant: 20).isActive = true
            barbutton.imageInsets.left = -10
        }
    }
}

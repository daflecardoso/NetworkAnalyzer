//
//  Global+Extension.swift
//  NetworkAnalyzer
//
//  Created by Dafle on 28/09/21.
//

import Foundation

protocol Appliable {}

extension Appliable {
    @discardableResult
    func apply(closure: (Self) -> Void) -> Self {
        closure(self)
        return self
    }
}

protocol Runnable {}

extension Runnable {
    @discardableResult
    func run<T>(closure: (Self) -> T) -> T {
        return closure(self)
    }
}

extension NSObject: Appliable {}
extension NSObject: Runnable {}

protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

extension ClassNameProtocol {
    static var className: String {
        return String(describing: self)
    }

    var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol {}

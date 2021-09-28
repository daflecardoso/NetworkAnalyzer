//
//  TrackingRequestResponse.swift
//  iCar
//
//  Created by Dafle Cardoso on 23/04/21.
//  Copyright © 2021 Dafle Cardoso. All rights reserved.
//

import Foundation
import UIKit

public struct NetworkAnalyzerData: Codable {
    
    public init(baseUrl: String,
                method: String,
                path: String,
                absoluteUrl: String,
                headers: String,
                query: String,
                requestBody: String,
                statusCode: Int,
                response: String,
                date: Date) {
        self.baseUrl = baseUrl
        self.method = method
        self.path = path
        self.absoluteUrl = absoluteUrl
        self.headers = headers
        self.query = query
        self.requestBody = requestBody
        self.statusCode = statusCode
        self.response = response
        self.date = date
    }
    
    
    public let baseUrl: String
    public let method: String
    public let path: String
    public let absoluteUrl: String
    public let headers: String
    public let query: String
    public let requestBody: String
    public let statusCode: Int
    public let response: String
    public let date: Date
    
    var methodColor: UIColor {
        switch method {
        case "GET":
            return UIColor(red: 35/255, green: 168/255, blue: 84/255, alpha: 1.0)
        case "POST":
            return UIColor(red: 198/255, green: 142/255, blue: 45/255, alpha: 1.0)
        case "PUT":
            return UIColor(red: 8/255, green: 107/255, blue: 190/255, alpha: 1.0)
        case "DELETE":
            return UIColor(red: 208/255, green: 32/255, blue: 40/255, alpha: 1.0)
        default:
            return .black
        }
    }
    
    var statusCodeColor: UIColor {
        if (200...299).contains(statusCode) {
            return UIColor(red: 35/255, green: 168/255, blue: 84/255, alpha: 1.0)
        } else {
            return UIColor(red: 208/255, green: 32/255, blue: 40/255, alpha: 1.0)
        }
    }
}

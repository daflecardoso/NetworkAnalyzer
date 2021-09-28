//
//  NetworkAnalyzerPlugin.swift
//  iCar
//
//  Created by Dafle Cardoso on 23/04/21.
//  Copyright © 2021 Dafle Cardoso. All rights reserved.
//

import Foundation

extension Dictionary where Key == String {
    var queryString: String {
        var output: String = ""
        let keysSorted = keys.sorted(by: <)
        
        for key in keysSorted {
            output += "\(key)=\(String(describing: self[key] ?? "" as? Value))&"
        }
        output = String(output.dropLast())
        return output
    }
}

//class NetworkAnalyzerPlugin: PluginType {
//
//    func willSend(_ request: RequestType, target: TargetType) {
//
//    }
//
//    func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
//
//        let requestBody: String
//        var query: String = ""
//        switch target.task {
//        case .requestPlain:
//            requestBody = ".requestPlain"
//        case .requestJSONEncodable(let encodable):
//            requestBody = (encodable.data.prettyPrintedJSONString ?? "null") as String
//        case .requestParameters(let parameters, _):
//            requestBody = ""
//            query = (parameters.data.prettyPrintedJSONString ?? "null") as String
//        case .requestCompositeData(let bodyData, let urlParameters):
//            requestBody = (bodyData.prettyPrintedJSONString ?? "null") as String
//            query = (urlParameters.data.prettyPrintedJSONString ?? "null") as String
//        default:
//            requestBody = "default"
//        }
//
//        let statusCode: Int
//        let responseBody: String
//        let absoluteUrl: String
//        switch result {
//        case .success(let response):
//            absoluteUrl = response.request?.url?.absoluteString ?? ""
//            statusCode = response.statusCode
//            responseBody = (response.data.prettyPrintedJSONString ?? "") as String
//        case .failure(let error):
//            absoluteUrl = error.response?.request?.url?.absoluteString ?? ""
//            statusCode = error.response?.statusCode ?? 0
//            responseBody = (error.response?.data.prettyPrintedJSONString ?? "") as String
//        }
//
//        let newEvent = NetworkAnalyzerData(method: target.method.rawValue,
//                                           baseUrl: target.baseURL.absoluteString,
//                                           path: target.path,
//                                           absoluteUrl: absoluteUrl,
//                                           headers: (target.headers?.data.prettyPrintedJSONString ?? "null") as String,
//                                           query: query,
//                                           requestBody: requestBody,
//                                           statusCode: statusCode,
//                                           response: responseBody,
//                                           date: Date())
//        let events: [NetworkAnalyzerData] = Cache.shared.get(forKey: .networkEvents) ?? []
//        Cache.shared.set([newEvent] + events , forKey: .networkEvents)
//    }
//}

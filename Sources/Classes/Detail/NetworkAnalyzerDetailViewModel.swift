//
//  NetworkAnalyzerDetailViewModel.swift
//  iCar
//
//  Created by Dafle Cardoso on 23/04/21.
//  Copyright © 2021 Dafle Cardoso. All rights reserved.
//

import Foundation

class NetworkAnalyzerDetailViewModel {
    
    internal let networkAnalyzer: NetworkAnalyzerData
    
    init(networkAnalyzer: NetworkAnalyzerData) {
        self.networkAnalyzer = networkAnalyzer
    }
    
    func text(for type: SegmentRequestOptions) -> String {
        switch type {
        case .header:
            return networkAnalyzer.headers
        case .request:
            return networkAnalyzer.requestBody
        case .response:
            return networkAnalyzer.response
        case .query:
            return networkAnalyzer.query
        }
    }
    
    func makeLogText() -> String {
        let headers = text(for: .header)
        let query = text(for: .query)
        let request = text(for: .request)
        let response = text(for: .response)
        
        return """
URL: \(networkAnalyzer.absoluteUrl)

Headers: \(headers)

-----------------------------------------------------------------------------

Query: \(query)

-----------------------------------------------------------------------------

Request: \(request)

-----------------------------------------------------------------------------

Response: \(response)
"""
    }
    
    func prettyText(type: SegmentRequestOptions) -> String {
        let text = text(for: type)
        let data = text.data(using: .utf8) ?? Data()
        return data.isValidJson ? (data.prettyPrintedJSONString ?? "") : text
    }
    
    func makeHTML(type: SegmentRequestOptions) -> String {
        return """
<!doctype html>
<html lang="">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title></title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel=stylesheet href=https://cdn.jsdelivr.net/npm/pretty-print-json@1.1/dist/pretty-print-json.css>
</head>
<body>
<pre id=account></pre>

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src=https://cdn.jsdelivr.net/npm/pretty-print-json@1.1/dist/pretty-print-json.min.js></script>

<script>

            const data = \(text(for: type))
            const elem = document.getElementById('account');
            elem.innerHTML = prettyPrintJson.toHtml(data);

</script>
</body>
</html>
"""
    }
}


extension String {
    
//    func jsonAttributed() -> NSAttributedString {
//        
//    }
}

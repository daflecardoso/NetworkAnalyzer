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
    
    func makeHTMLEditor(type: SegmentRequestOptions, webviewHeight: CGFloat) -> (String, URL) {
        guard let filePath = NetworkAnalyzer.bundle.path(forResource: "json_preview", ofType: "html")
        else {
            // File Error
            print ("File reading error")
            return ("", URL(string: "")!)
        }
        
        //let contents =  try? String(contentsOfFile: filePath, encoding: .utf8)
        let baseUrl = URL(fileURLWithPath: filePath)
        
        
        let contents = """
<!DOCTYPE HTML>
<html lang="en">
<head>
    <!-- when using the mode "code", it's important to specify charset utf-8 -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="jsoneditor.min.css" rel="stylesheet" type="text/css">
    <script src="jsoneditor.min.js"></script>
    <link href="darktheme.css" rel="stylesheet" type="text/css">
</head>
<body>
    <div style="width: 100%; height: \(webviewHeight)px;" id="jsoneditor"></div>

    <script>
        // create the editor
        const container = document.getElementById("jsoneditor")
        const options = {
            "mode": "code",
            "modes": ['code', 'form', 'text', 'tree', 'view', 'preview'],
            "search": false,
            onEditable: function (node) {
              if (!node.path) {
                // In modes code and text, node is empty: no path, field, or value
                // returning false makes the text area read-only
                return false;
              }
            },
        }
        const editor = new JSONEditor(container, options)
     
        // set json
        const initialJson = \(text(for: type))
        editor.set(initialJson)
    </script>
</body>
</html>
"""
        
        return (contents, baseUrl)
    }
}

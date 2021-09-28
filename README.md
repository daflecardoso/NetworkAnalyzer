# NetworkAnalyzer 1.1.0

[![CI Status](https://img.shields.io/travis/daflecardoso/NetworkAnalyzer.svg?style=flat)](https://travis-ci.org/daflecardoso/NetworkAnalyzer)
[![Version](https://img.shields.io/cocoapods/v/NetworkAnalyzer.svg?style=flat)](https://cocoapods.org/pods/NetworkAnalyzer)
[![License](https://img.shields.io/cocoapods/l/NetworkAnalyzer.svg?style=flat)](https://cocoapods.org/pods/NetworkAnalyzer)
[![Platform](https://img.shields.io/cocoapods/p/NetworkAnalyzer.svg?style=flat)](https://cocoapods.org/pods/NetworkAnalyzer)

## Example

Light mode             |  Dark mode
:-------------------------:|:-------------------------:
<img src="../master/light_example.gif" alt="Light mode" width="200px"/>  |  <img src="../master/dark_example.gif" alt="Dark mode" width="200px"/>




To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

NetworkAnalyzer is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'NetworkAnalyzer'
```

## Usage

Insert data event

```swift
private func inserEvent() {
    let baseUrl = "https://api.something.com"
    let path = "/some/path"
    let headers = "\"Authorization\": \"Bearer 31cah32....\""
    let query = "some=data&something=anotherData"
    let requestBody = "{\"firstName\": \"Network\" }"
    let response = "{\"lasName\": \"Analyzer\" }"

    let event = NetworkAnalyzerData(baseUrl: baseUrl,
                                    method: "GET",
                                    path: path,
                                    absoluteUrl: baseUrl + path,
                                    headers: headers,
                                    query: query,
                                    requestBody: requestBody,
                                    statusCode: 200,
                                    response: response,
                                    date: Date())
    NetworkAnalyzer.shared.insert(event: event)
}
```

Show network area example

```swift
let controller = NetworkAnalyzer.shared.makeNetworkAnalyzerViewController()
let navigation = UINavigationController(rootViewController: controller)
present(navigation, animated: true, completion: nil)
```

## Author

daflecardoso, daflesantos@gmail.com

## License

NetworkAnalyzer is available under the MIT license. See the LICENSE file for more info.

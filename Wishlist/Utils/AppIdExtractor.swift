import Foundation

final class AppIdExtractor {
    //TODO: What formats to support?!
    static func appIdFrom(urlString: String) -> String? {
        if let idRange = urlString.range(of: "/id") {
            let trailing = urlString[idRange.upperBound...]
            if let paramsRange = trailing.range(of: "?") {
                let string = String(trailing[..<paramsRange.lowerBound])
                return string
            }
        }

        return nil
    }
}

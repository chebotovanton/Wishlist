import Foundation

final class AppIdExtractor {
    static func appIdFrom(urlString: String) -> String? {
        if let idRange = urlString.range(of: "/id") {
            let trailing = urlString[idRange.upperBound...]
            if let paramsRange = trailing.range(of: "?") {
                return String(trailing[..<paramsRange.lowerBound])
            }
        }

        return nil
    }
}

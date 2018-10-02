import UIKit

class PasteboardHandler {

    static func getPasteboardId() -> String? {
        for string in UIPasteboard.general.strings ?? [] {
            if let appId = AppIdExtractor.appIdFrom(urlString: string), !AppsKeeper.hasAppId(appId: appId) {
                return appId
            }
        }

        return nil
    }
}

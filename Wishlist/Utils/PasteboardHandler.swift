import UIKit

class PasteboardHandler {

    static func checkPasteboard(controller: UIViewController) {
        if let appId = getPasteboardId() {
            let alert = UIAlertController(title: "Add app to Wishlist", message: "We detected a link in your buffer — don’t be shy, tap the field below", preferredStyle: .alert)

            let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                AppsKeeper.addAppId(appId: appId)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(okAction)
            alert.addAction(cancelAction)

            controller.present(alert, animated: true, completion: nil)
        }
    }

    static func getPasteboardId() -> String? {
        for string in UIPasteboard.general.strings ?? [] {
            NSLog(string)
            if let appId = AppIdExtractor.appIdFrom(urlString: string), !AppsKeeper.hasAppId(appId: appId) {
                return appId
            }
        }

        return nil
    }

}

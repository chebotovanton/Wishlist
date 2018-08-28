import UIKit

class PasteboardHandler {

    static let notificationName = "AppIdAdded"

    static func checkPasteboard(controller: UIViewController) {
        //tests!
        if let appId = getPasteboardId() {
            proposeToAddAppId(appId: appId, controller: controller)
        }
    }

    static func getPasteboardId() -> String? {
        for string in UIPasteboard.general.strings ?? [] {
            if let appId = AppIdExtractor.appIdFrom(urlString: string), !AppsKeeper.hasAppId(appId: appId) {
                return appId
            }
        }

        return nil
    }

    private static func proposeToAddAppId(appId: String, controller: UIViewController) {
        let alert = UIAlertController(title: "Add app to Wishlist", message: "We detected a link in your buffer — don’t be shy, tap the field below", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            addAppId(appId: appId)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)

        controller.present(alert, animated: true, completion: nil)
    }

    private static func addAppId(appId: String) {
        AppsKeeper.addAppId(appId: appId)
        notifyDidAddAppId()
    }

    private static func notifyDidAddAppId() {
        let notification = Notification(name: Notification.Name(rawValue: notificationName))
        NotificationCenter.default.post(notification)
    }

}

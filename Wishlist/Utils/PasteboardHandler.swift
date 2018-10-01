import UIKit

class PasteboardHandler {

    static func checkPasteboard(controller: UIViewController) {
        //tests!
        if let appId = getPasteboardId() {
            proposeToAddAppId(appId: appId, controller: controller)
        } else {
            RateUsManager.requestReview()
        }
    }

    private static func getPasteboardId() -> String? {
        for string in UIPasteboard.general.strings ?? [] {
            if let appId = AppIdExtractor.appIdFrom(urlString: string), !AppsKeeper.hasAppId(appId: appId) {
                return appId
            }
        }

        return nil
    }

    private static func proposeToAddAppId(appId: String, controller: UIViewController) {
        let newAppVC = NewAppVC(nibName: "NewAppVC", bundle: nil)
        newAppVC.appId = appId
        newAppVC.modalPresentationStyle = .overCurrentContext
        controller.present(newAppVC, animated: true, completion: nil)
    }
}

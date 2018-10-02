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

    static func getPasteboardId() -> String? {
        for string in UIPasteboard.general.strings ?? [] {
            if let appId = AppIdExtractor.appIdFrom(urlString: string), !AppsKeeper.hasAppId(appId: appId) {
                return appId
            }
        }

        return nil
    }

    private static func proposeToAddAppId(appId: String, controller: UIViewController) {
        //TODO: Got weird
        if let navVC = controller as? UINavigationController, let listVC = navVC.viewControllers.first as? ListVC, let presenter = listVC.presenter as? NewAppVCDelegate {
            let newAppVC = NewAppVC(nibName: "NewAppVC", delegate: presenter, appId: appId)
            controller.present(newAppVC, animated: true, completion: nil)
        }
    }
}

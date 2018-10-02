import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.makeKeyAndVisible()
        let listVC = ListVC(nibName: "ListVC", bundle: nil)
        let navVC = UINavigationController(rootViewController: listVC)
        navVC.isNavigationBarHidden = true
        window!.rootViewController = navVC

        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        checkPasteboard()
    }

    private func checkPasteboard() {
        if let controller = self.window?.rootViewController, let appId = PasteboardHandler.getPasteboardId() {
            proposeToAddAppId(appId: appId, controller: controller)
        } else {
            UserDefaultsManager.increaseLaunchCount()
            RateUsManager.requestReview()
        }
    }

    private func proposeToAddAppId(appId: String, controller: UIViewController) {
        //TODO: Got too weird
        if let navVC = controller as? UINavigationController, let listVC = navVC.viewControllers.first as? ListVC, let presenter = listVC.presenter as? NewAppVCDelegate {
            let newAppVC = NewAppVC(nibName: "NewAppVC", delegate: presenter, appId: appId)
            controller.present(newAppVC, animated: true, completion: nil)
        }
    }
}

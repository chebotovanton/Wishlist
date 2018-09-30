import UIKit

class NewAppVC: UIViewController {

    //TODO: Move const somewhere
    static let notificationName = "AppIdAdded"

    @IBOutlet private weak var saveButton: UIButton?

    var appId: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        addBlurredBackground()

        saveButton?.layer.cornerRadius = 12
        saveButton?.clipsToBounds = true
    }

    @IBAction private func addAppId() {
        if let appId = self.appId {
            AppsKeeper.addAppId(appId: appId)
            notifyDidAddAppId()
        }
    }

    private func notifyDidAddAppId() {
        let notification = Notification(name: Notification.Name(rawValue: NewAppVC.notificationName))
        NotificationCenter.default.post(notification)
        close()
    }
}

import UIKit
import StoreKit

class AppDetailsVC: UIViewController, SKStoreProductViewControllerDelegate {

    private var appInfo: AppInfo?
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var descriptionLabel: UILabel?

    @IBOutlet private weak var iconView: UIImageView?
    @IBOutlet private weak var priceLabel: UILabel?
    @IBOutlet private weak var ratingLabel: UILabel?
    @IBOutlet private weak var starsView: StarsView?

    @IBOutlet private weak var appStoreBackground: UIView?

    func setup(_ appInfo: AppInfo) {
        self.appInfo = appInfo

        titleLabel?.text = appInfo.name
        descriptionLabel?.text = appInfo.description
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        iconView?.layer.cornerRadius = 18
        iconView?.clipsToBounds = true

        appStoreBackground?.layer.cornerRadius = 12
        appStoreBackground?.clipsToBounds = true

        if let appInfo = self.appInfo {
            setup(info: appInfo)
        }
    }

    private func setup(info: AppInfo) {
        titleLabel?.text = info.name
        descriptionLabel?.text = info.description

        priceLabel?.text = info.formattedPrice
        ratingLabel?.text = String(info.rating)
        starsView?.setup(rating: info.rating)
        iconView?.sd_setImage(with: URL(string: info.iconUrlString), completed: nil)
    }

    @IBAction private func goBack() {
        navigationController?.popViewController(animated: true)
    }

    @IBAction private func openAppStore() {
        if let appId = appInfo?.appId {
            openStoreProduct(appStoreId: appId)
        }
    }

    private func openStoreProduct(appStoreId: String) {
        let storeViewController = SKStoreProductViewController()
        storeViewController.delegate = self

        let parameters = [ SKStoreProductParameterITunesItemIdentifier : appStoreId]
        storeViewController.loadProduct(withParameters: parameters) { [weak self] (loaded, error) -> Void in
//            if loaded {
//                self?.present(storeViewController, animated: true, completion: nil)
//            }
        }
        present(storeViewController, animated: true, completion: nil)
    }

    func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
}

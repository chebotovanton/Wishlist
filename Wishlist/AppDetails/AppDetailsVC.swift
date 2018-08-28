import UIKit

class AppDetailsVC: UIViewController {

    private var appInfo: AppInfo?
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var descriptionLabel: UILabel?

    @IBOutlet private weak var iconView: UIImageView?
    @IBOutlet private weak var priceLabel: UILabel?
    //replace with stars view
    @IBOutlet private weak var ratingLabel: UILabel?

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
        iconView?.sd_setImage(with: URL(string: info.iconUrlString), completed: nil)
    }

    override func viewDidLayoutSubviews() {
        view.addGradient(startColor: UIColor(red: 240.0/255.0, green: 147.0/255.0, blue: 251.0/255.0, alpha: 1),
                         endColor: UIColor(red: 245.0/255.0, green: 87.0/255.0, blue: 108.0/255.0, alpha: 1))
    }

    @IBAction private func goBack() {
        navigationController?.popViewController(animated: true)
    }

}

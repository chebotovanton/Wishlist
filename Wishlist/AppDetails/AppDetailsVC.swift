import UIKit

class AppDetailsVC: UIViewController {

    private var appInfo: AppInfo?
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var descriptionLabel: UILabel?

    func setup(_ appInfo: AppInfo) {
        self.appInfo = appInfo

        titleLabel?.text = appInfo.name
        descriptionLabel?.text = appInfo.description
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel?.text = appInfo?.name
        descriptionLabel?.text = appInfo?.description
    }

    override func viewDidLayoutSubviews() {
        view.addGradient(startColor: UIColor(red: 240.0/255.0, green: 147.0/255.0, blue: 251.0/255.0, alpha: 1),
                         endColor: UIColor(red: 245.0/255.0, green: 87.0/255.0, blue: 108.0/255.0, alpha: 1))
    }

    @IBAction private func goBack() {
        navigationController?.popViewController(animated: true)
    }

}

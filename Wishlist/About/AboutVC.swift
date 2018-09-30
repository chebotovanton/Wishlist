import UIKit

class AboutVC: UIViewController {

    @IBOutlet private weak var appIcon: UIImageView?

    override func viewDidLoad() {
        super.viewDidLoad()

        appIcon?.layer.cornerRadius = 18
        appIcon?.clipsToBounds = true

        addBlurredBackground()
    }
}

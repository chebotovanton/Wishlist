import UIKit

class AboutVC: UIViewController {

    @IBOutlet private weak var appIcon: UIImageView?

    override func viewDidLoad() {
        super.viewDidLoad()

        appIcon?.layer.cornerRadius = 18
        appIcon?.clipsToBounds = true

        let blurredBackgroundView = UIVisualEffectView()
        blurredBackgroundView.frame = view.frame
        blurredBackgroundView.effect = UIBlurEffect(style: .dark)
        view.addSubview(blurredBackgroundView)
        view.sendSubview(toBack: blurredBackgroundView)
    }

    @IBAction private func close() {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }

}

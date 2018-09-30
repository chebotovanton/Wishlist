import UIKit

protocol BlurredModalProtocol {
    func addBlurredBackground()
    func close()
}

extension UIViewController: BlurredModalProtocol {
    func addBlurredBackground() {
        let blurredBackgroundView = UIVisualEffectView()
        blurredBackgroundView.frame = view.frame
        blurredBackgroundView.effect = UIBlurEffect(style: .dark)
        view.addSubview(blurredBackgroundView)
        view.sendSubview(toBack: blurredBackgroundView)
        view.backgroundColor = .clear
    }

    @IBAction func close() {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

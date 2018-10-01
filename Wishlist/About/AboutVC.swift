import UIKit

class AboutVC: UIViewController {

    @IBOutlet private weak var appIcon: UIImageView?
    @IBOutlet private weak var emailButton: UIButton?
    private var emailSender: EmailSender?

    override func viewDidLoad() {
        super.viewDidLoad()

        appIcon?.layer.cornerRadius = 18
        appIcon?.clipsToBounds = true

        addBlurredBackground()
        emailButton?.isHidden = !EmailSender.canSendEmail()
    }

    @IBAction private func writeUs() {
        let sender = EmailSender()
        sender.prepareToSendMail()
        present(sender.mailComposeVC, animated: true, completion: nil)
        emailSender = sender
    }
}

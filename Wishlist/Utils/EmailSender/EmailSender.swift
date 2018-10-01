import MessageUI

class EmailSender: NSObject, MFMailComposeViewControllerDelegate {

    private (set) var mailComposeVC = MFMailComposeViewController()

    static func canSendEmail() -> Bool {
        return MFMailComposeViewController.canSendMail()
    }

    func prepareToSendMail() {
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setSubject("Wishlist App rocks!")
        mailComposeVC.setToRecipients(["wishlistapp@yandex.ru"])
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        mailComposeVC.dismiss(animated: true, completion: nil)
    }
}

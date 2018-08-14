import UIKit
import Social
import MobileCoreServices

class ShareViewController: SLComposeServiceViewController {

    private var urlString: String?
    private var textString: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        let extensionItem = extensionContext?.inputItems[0] as! NSExtensionItem
        let contentTypeURL = kUTTypeURL as String
        let contentTypeText = kUTTypeText as String
        let attachments = extensionItem.attachments as! [NSItemProvider]

        for attachment in attachments {
            if attachment.hasItemConformingToTypeIdentifier(contentTypeURL) {
                attachment.loadItem(forTypeIdentifier: contentTypeURL, options: nil, completionHandler: { (results, error) in
                    let url = results as! URL?
                    self.urlString = url!.absoluteString
                })
            }
            if attachment.hasItemConformingToTypeIdentifier(contentTypeText) {
                attachment.loadItem(forTypeIdentifier: contentTypeText, options: nil, completionHandler: { (results, error) in
                    self.textString = results as? String
                })
            }
        }
    }

    override func isContentValid() -> Bool {
        if let url = urlString, let _ = AppIdExtractor.appIdFrom(urlString: url) {
            return true
        }
        if let text = textString, let _ = AppIdExtractor.appIdFrom(urlString: text) {
            return true
        }
        return false
    }

    override func didSelectPost() {
        if let url = urlString, let appId = AppIdExtractor.appIdFrom(urlString: url) {
            AppsKeeper.addAppId(appId: appId)
        } else if let text = textString, let appId = AppIdExtractor.appIdFrom(urlString: text) {
            AppsKeeper.addAppId(appId: appId)
        }

        super.didSelectPost()
    }

    override func configurationItems() -> [Any]! {
        return []
    }

}

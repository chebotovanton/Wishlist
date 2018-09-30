import UIKit
import Social
import MobileCoreServices

class ShareViewController: SLComposeServiceViewController {

    private var urlString: String?
    private var textString: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let extensionItem = extensionContext?.inputItems[0] as? NSExtensionItem else { return }
        let contentTypeURL = kUTTypeURL as String
        let contentTypeText = kUTTypeText as String
        guard let attachments = extensionItem.attachments as? [NSItemProvider] else { return }

        for attachment in attachments {
            if attachment.hasItemConformingToTypeIdentifier(contentTypeURL) {
                attachment.loadItem(forTypeIdentifier: contentTypeURL, options: nil, completionHandler: { (results, error) in
                    if let url = results as? URL {
                        self.urlString = url.absoluteString
                    }
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
        //TODO: What's going on here?
        if let url = urlString, AppIdExtractor.appIdFrom(urlString: url) != nil {
            return true
        }
        if let text = textString, AppIdExtractor.appIdFrom(urlString: text) != nil {
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

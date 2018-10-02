import UIKit
import Social
import MobileCoreServices

//TODO: Can we test anything here?
class ShareViewController: SLComposeServiceViewController {
    private var appId: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let extensionItem = extensionContext?.inputItems[0] as? NSExtensionItem else { return }
        let contentTypeURL = kUTTypeURL as String
        let contentTypeText = kUTTypeText as String
        guard let attachments = extensionItem.attachments as? [NSItemProvider] else { return }

        for attachment in attachments {
            if attachment.hasItemConformingToTypeIdentifier(contentTypeURL) {
                attachment.loadItem(forTypeIdentifier: contentTypeURL, options: nil, completionHandler: { (results, error) in
                    if let url = results as? URL, let appId = AppIdExtractor.appIdFrom(urlString: url.absoluteString) {
                        self.appId = appId
                        _ = self.isContentValid()
                    }
                })
            }
            if attachment.hasItemConformingToTypeIdentifier(contentTypeText) {
                attachment.loadItem(forTypeIdentifier: contentTypeText, options: nil, completionHandler: { (results, error) in
                    if let text = results as? String, let appId = AppIdExtractor.appIdFrom(urlString: text) {
                        self.appId = appId
                        _ = self.isContentValid()
                    }
                })
            }
        }
    }

    override func isContentValid() -> Bool {
        return appId != nil
    }

    override func didSelectPost() {
        if let appId = self.appId {
            AppsKeeper.addAppId(appId: appId)
        }
        super.didSelectPost()
    }

    override func configurationItems() -> [Any]! {
        return []
    }
}

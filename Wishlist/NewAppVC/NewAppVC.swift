import UIKit

protocol NewAppVCDelegate: class {
    func didAddApp(appId: String)
}

class NewAppVC: UIViewController {
    weak var delegate: NewAppVCDelegate?
    @IBOutlet private weak var saveButton: UIButton?
    var appId: String

    init(nibName: String, delegate: NewAppVCDelegate, appId: String) {
        self.appId = appId
        self.delegate = delegate

        super.init(nibName: nibName, bundle: nil)

        modalPresentationStyle = .overCurrentContext
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        addBlurredBackground()

        saveButton?.layer.cornerRadius = 12
        saveButton?.clipsToBounds = true
    }

    @IBAction private func addAppId() {
        AppsKeeper.addAppId(appId: appId)
        delegate?.didAddApp(appId: appId)
    }
}

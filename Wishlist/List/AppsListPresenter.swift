import UIKit

protocol AppListPresenterProtocol {
    func showNewAppPage()
    func showAboutPage()
    func showAppInfo(appInfo: AppInfo)
    func getAppsInfo()
    func setController(controller: ListVC)
}

final class AppsListPresenter: AppListPresenterProtocol, AppInfoLoaderDelegate, NewAppVCDelegate {
    var infoLoaders: [AppInfoLoader] = []
    var items: [AppListItem] = []
    weak var controller: ListVC?

    func getAppsInfo() {
        items = []
        let appIds = AppsKeeper.getSavedAppIds()
        for appId in appIds {
            let loader = AppInfoLoader(appId: appId)
            loader.delegate = self
            loader.loadAppInfo()
            infoLoaders.append(loader)

            items.append(AppListItem(appId: appId))
        }

        controller?.updateList(items)
    }

    func didFailLoading(_ appId: String, loader: AppInfoLoader ) {
        //TODO: should we notify user? What to show to user?
        if let index = infoLoaders.index(where: { (loader) -> Bool in loader.appId == appId}) {
            infoLoaders.remove(at: index)
        }
    }

    func didLoadAppInfo(_ info: AppInfo, loader: AppInfoLoader, appId: String) {
        if let index = infoLoaders.index(where: { (loader) -> Bool in loader.appId == appId}) {
            infoLoaders.remove(at: index)
        }
        for item in items where item.appId == appId {
            item.appInfo = info
            break
        }
        controller?.updateList(items)
    }

    // MARK: - AppListPresenterProtocol
    //TODO: What's the right direction of control?
    func setController(controller: ListVC) {
        self.controller = controller
    }

    func showAboutPage() {
        let aboutVC = AboutVC(nibName: "AboutVC", bundle: nil)
        aboutVC.modalPresentationStyle = .overCurrentContext
        controller?.present(aboutVC, animated: true, completion: nil)
    }

    func showNewAppPage() {
        if let appId = PasteboardHandler.getPasteboardId() {
            let newAppVC = NewAppVC(nibName: "NewAppVC", delegate: self, appId: appId)
            controller?.present(newAppVC, animated: true, completion: nil)
        }
    }

    func showAppInfo(appInfo: AppInfo) {
        let detailsVC = AppDetailsVC(nibName: "AppDetailsVC", bundle: nil)
        detailsVC.setup(appInfo)
        controller?.navigationController?.pushViewController(detailsVC, animated: true)
    }

    // MARK: - NewAppVCDelegate
    func didAddApp(appId: String) {
        getAppsInfo()
        controller?.dismiss(animated: true, completion: nil)
    }

}

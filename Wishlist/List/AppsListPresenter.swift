final class AppsListPresenter: AppInfoLoaderDelegate {

    var infoLoaders: [AppInfoLoader] = []
    var items: [AppListItem] = []
    weak var controller: ListVC?

    func getAppsInfo() {
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
        //warning: should we notify user?
        if let index = infoLoaders.index(where: { (loader) -> Bool in loader.appId == appId})  {
            infoLoaders.remove(at: index)
        }
    }

    func didLoadAppInfo(_ info: AppInfo, loader: AppInfoLoader, appId: String) {
        if let index = infoLoaders.index(where: { (loader) -> Bool in loader.appId == appId})  {
            infoLoaders.remove(at: index)
        }
        for item in items {
            if item.appId == appId {
                item.appInfo = info
            }
        }
        controller?.updateList(items)
    }

}

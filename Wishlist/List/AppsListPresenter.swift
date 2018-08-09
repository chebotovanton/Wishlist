class AppsListPresenter: AppInfoLoaderDelegate {

    let infoLoader = AppInfoLoader()
    weak var controller: ListVC?

    func getAppsInfo() {
        infoLoader.delegate = self
        let appIds = AppsKeeper.getSavedAppIds()
        if let appId = appIds.first {
            infoLoader.loadAppInfo(appId: appId)
        }
    }

    func didFailLoading(_ appId: String) {
        //warning: show alert?
    }

    func didLoadAppInfo(_ info: AppInfo) {
        let items = [AppListItem(appInfo: info)]

        controller?.updateList(items)
    }

}

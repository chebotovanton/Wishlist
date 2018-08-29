import Alamofire
import AlamofireObjectMapper

protocol AppInfoLoaderDelegate: class {
    func didLoadAppInfo(_ info: AppInfo, loader: AppInfoLoader, appId: String)
    func didFailLoading(_ appId: String, loader: AppInfoLoader)
}

final class AppInfoLoader {

    private let baseUrl = "https://itunes.apple.com/lookup?"

    weak var delegate: AppInfoLoaderDelegate?
    var appId: String

    init(appId: String) {
        self.appId = appId
    }

    func loadAppInfo() {
        //warning: that's ugly. Add appId to appInfo in a proper manner
        let params = ["id" : appId]
        Alamofire.request(baseUrl, parameters:params).responseObject { [weak self] (response: DataResponse<AppInfoResponse>) in
            guard var info = response.result.value?.info.first else {
                self?.delegate?.didFailLoading(self!.appId, loader: self!)
                return
            }
            info.appId = self?.appId
            self?.delegate?.didLoadAppInfo(info, loader: self!, appId: self!.appId)
        }
    }
}

import Alamofire
import AlamofireObjectMapper

protocol AppInfoLoaderDelegate: class {
    func didLoadAppInfo(_ info: AppInfo, loader: AppInfoLoader, appId: String)
    func didFailLoading(_ appId: String, loader: AppInfoLoader)
}

class AppInfoLoader {

    private let baseUrl = "https://itunes.apple.com/lookup?"

    weak var delegate: AppInfoLoaderDelegate?
    var appId: String

    init(appId: String) {
        self.appId = appId
    }

    func loadAppInfo() {
        let params = ["id" : appId]
        Alamofire.request(baseUrl, parameters:params).responseObject { [weak self] (response: DataResponse<AppInfoResponse>) in
            guard let info = response.result.value?.info.first else {
                self?.delegate?.didFailLoading(self!.appId, loader: self!)
                return
            }

            self?.delegate?.didLoadAppInfo(info, loader: self!, appId: self!.appId)
        }
    }
}

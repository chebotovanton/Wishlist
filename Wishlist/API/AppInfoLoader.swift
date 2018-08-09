import Alamofire
import AlamofireObjectMapper

protocol AppInfoLoaderDelegate: class {
    func didLoadAppInfo(_ info: AppInfo)
    func didFailLoading(_ appId: String)
}

class AppInfoLoader {

    private let baseUrl = "https://itunes.apple.com/lookup?"

    weak var delegate: AppInfoLoaderDelegate?

    func loadAppInfo(appId: String) {
        let params = ["id" : appId]
        Alamofire.request(baseUrl, parameters:params).responseObject { [weak self] (response: DataResponse<AppInfoResponse>) in
            guard let info = response.result.value?.info.first else {
                self?.delegate?.didFailLoading(appId)
                return
            }

            self?.delegate?.didLoadAppInfo(info)
        }
    }
}

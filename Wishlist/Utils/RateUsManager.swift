import StoreKit

class RateUsManager {

    static func requestReview() {
        let launchCount = UserDefaultsManager.getLaunchCount()
        if launchCount % 4 == 0 {
            doRequestReview()
        }
    }

    static private func doRequestReview() {
        SKStoreReviewController.requestReview()
    }

}

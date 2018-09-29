import Foundation

final class AppsKeeper {

    private static let kAppsIdsKey = "kAppsIdsKey"

    static func getSavedAppIds() -> [String] {
        let array = userDefaults().array(forKey: kAppsIdsKey)
        return array as? [String] ?? ["1155618808", "1147642630", "1157416619", "762156897"]
    }

    static func addAppId(appId: String) {
        var array = getSavedAppIds()
        array.append(appId)
        userDefaults().set(array, forKey: kAppsIdsKey)
    }

    static func removeAppId(appId: String) {
        var array = getSavedAppIds()
        if let index = array.index(of: appId) {
            array.remove(at: index)
            userDefaults().set(array, forKey: kAppsIdsKey)
        }
    }

    static func hasAppId(appId: String) -> Bool {
        return getSavedAppIds().contains(appId)
    }

    private static func userDefaults() -> UserDefaults {
        return UserDefaults(suiteName: "group.com.wishlist.group")!
    }
}

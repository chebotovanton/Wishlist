import Foundation

class UserDefaultsManager {
    private static let kLaunchCountKey = "kLaunchCountKey"

    static func increaseLaunchCount() {
        let count = getLaunchCount() + 1
        UserDefaults.standard.set(count, forKey: kLaunchCountKey)
    }

    static func getLaunchCount() -> Int {
        return UserDefaults.standard.integer(forKey: kLaunchCountKey)
    }
}

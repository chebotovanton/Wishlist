import UIKit

final class AppListItem: NSObject {
    var appInfo: AppInfo?
    let appId: String

    init(appId: String) {
        self.appId = appId
    }

    func cellHeight() -> CGFloat {
        return 280.0
    }

    func cell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCell.reuseIdentifier(), for: indexPath)
        if let appCell = cell as? ListCell {
            appCell.setup(appInfo)
        }

        return cell
    }
}

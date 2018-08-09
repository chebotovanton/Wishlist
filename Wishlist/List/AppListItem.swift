import UIKit

class AppListItem: NSObject {
    private let appInfo: AppInfo

    init(appInfo: AppInfo) {
        self.appInfo = appInfo
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

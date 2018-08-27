import UIKit
import SDWebImage

final class ListVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CollectionSwipableCellExtensionDelegate {

    @IBOutlet private weak var collectionView: UICollectionView?
    private var items: [AppListItem] = []
    private let presenter = AppsListPresenter()
    private var swipeExtension: CollectionSwipableCellExtension?

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.register(UINib(nibName: "ListCell", bundle: nil), forCellWithReuseIdentifier: ListCell.reuseIdentifier())

        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView?.setCollectionViewLayout(layout, animated: false)
        collectionView?.alwaysBounceVertical = true

        if let collectionView = self.collectionView {
            swipeExtension = CollectionSwipableCellExtension(with: collectionView)
            swipeExtension?.delegate = self
            swipeExtension?.isEnabled = true
        }

        presenter.controller = self
        presenter.getAppsInfo()
    }

    func updateList(_ items: [AppListItem]) {
        self.items = items

        collectionView?.reloadData()
    }

    // MARK: - UICollectionViewDelegate, UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
        let sectionInset = (flowLayout?.sectionInset.right ?? 0) + (flowLayout?.sectionInset.left ?? 0)
        let contentInset = collectionView.contentInset.left + collectionView.contentInset.right
        let width = collectionView.frame.width - sectionInset - contentInset
        let height = items[indexPath.item].cellHeight()

        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return items[indexPath.item].cell(collectionView:collectionView, indexPath:indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.item]

        if let appInfo = item.appInfo {
            let detailsVC = AppDetailsVC(nibName: "AppDetailsVC", bundle: nil)
            detailsVC.setup(appInfo)
            navigationController?.pushViewController(detailsVC, animated: true)
        }
    }

    // MARK: - CollectionSwipableCellExtensionDelegate

    public func isSwipable(itemAt indexPath: IndexPath) -> Bool {
        return true
    }

    public func swipableActionsLayout(forItemAt indexPath: IndexPath) -> CollectionSwipableCellLayout? {

        let layout = CollectionSwipableCellOneButtonLayout(buttonWidth: 100, insets: UIEdgeInsets.zero, direction: .leftToRight)
        layout.button.setBackgroundImage(nil, for: .normal)
        layout.button.setTitle(nil, for: .normal)
        layout.button.setImage(UIImage(named: "remove"), for: .normal)
        layout.button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.button.backgroundColor = UIColor.clear
        layout.button.tintColor = .red

        layout.action = {[weak self] in
            guard let `self` = self else { return }
            guard indexPath.item < self.items.count else { return }

            let item = self.items[indexPath.item]
            AppsKeeper.removeAppId(appId: item.appId)
            self.items.remove(at: indexPath.item)
            self.collectionView?.deleteItems(at: [indexPath])
        }

        return layout
    }


}


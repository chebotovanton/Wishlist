import UIKit

class ListCell: UICollectionViewCell {

    @IBOutlet private weak var iconView: UIImageView?
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var descriptionLabel: UILabel?

    static func reuseIdentifier() -> String {
        return "ListCell"
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        backgroundColor = UIColor(red: 245.0/255.0, green: 87.0/255.0, blue: 108.0/255.0, alpha: 1)

        layer.cornerRadius = 18
        iconView?.layer.cornerRadius = 18
        iconView?.clipsToBounds = true
    }

    func setup(_ appInfo: AppInfo) {
        titleLabel?.text = appInfo.name
        descriptionLabel?.text = appInfo.description

        iconView?.sd_setImage(with: URL(string: appInfo.iconUrlString), completed: nil)
    }

}

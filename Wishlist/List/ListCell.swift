import UIKit

final class ListCell: UICollectionViewCell {

    @IBOutlet private weak var gradientView: GradientView?
    @IBOutlet private weak var iconView: UIImageView?
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var descriptionLabel: UILabel?
    @IBOutlet private weak var priceLabel: UILabel?
    @IBOutlet private weak var ratingLabel: UILabel?
    @IBOutlet private weak var starsView: StarsView?

    static func reuseIdentifier() -> String {
        return "ListCell"
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        gradientView?.layer.cornerRadius = 18
        gradientView?.clipsToBounds = true
        iconView?.layer.cornerRadius = 18
        iconView?.clipsToBounds = true
    }

    func setup(_ appInfo: AppInfo?) {
        if let appInfo = appInfo {
            titleLabel?.text = appInfo.name
            descriptionLabel?.text = appInfo.description
            priceLabel?.text = appInfo.formattedPrice
            ratingLabel?.text = String(appInfo.rating)
            starsView?.setup(rating: appInfo.rating)

            iconView?.sd_setImage(with: URL(string: appInfo.iconUrlString), completed: nil)
        } else {
            titleLabel?.text = "loading"
        }
    }
}

import UIKit

final class ListCell: UICollectionViewCell {

    @IBOutlet private weak var iconView: UIImageView?
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var descriptionLabel: UILabel?
    @IBOutlet private weak var priceLabel: UILabel?
    //replace with stars view
    @IBOutlet private weak var ratingLabel: UILabel?

    static func reuseIdentifier() -> String {
        return "ListCell"
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        layer.cornerRadius = 18
        iconView?.layer.cornerRadius = 18
        iconView?.clipsToBounds = true
    }

    func setup(_ appInfo: AppInfo?) {
        if let appInfo = appInfo {
            titleLabel?.text = appInfo.name
            descriptionLabel?.text = appInfo.description
            priceLabel?.text = appInfo.formattedPrice
            ratingLabel?.text = String(appInfo.rating) 

            iconView?.sd_setImage(with: URL(string: appInfo.iconUrlString), completed: nil)
        } else {
            titleLabel?.text = "loading"
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.addGradient(startColor: UIColor(red: 255.0/255.0, green: 169.0/255.0, blue: 163.0/255.0, alpha: 1),
                    endColor: UIColor(red: 194.0/255.0, green: 87.0/255.0, blue: 245.0/255.0, alpha: 1))
    }

}

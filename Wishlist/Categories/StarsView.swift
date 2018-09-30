import UIKit
import PureLayout

final class StarsView: UIView {
    private let stars: [UIImageView] = {
        var result: [UIImageView] = []
        for index in 0..<5 {
            let star = UIImageView()
            star.image = UIImage(named: "star")
            result.append(star)
        }
        return result
    }()

    override func awakeFromNib() {
        for star in stars {
            addSubview(star)
        }
        (stars as NSArray).autoDistributeViews(along: .horizontal,
                                               alignedTo: .top,
                                               withFixedSpacing: 1,
                                               insetSpacing: true,
                                               matchedSizes: true)
    }

    func setup(rating: Float) {
        let intRating = Int(rating)
        for index in 0..<intRating {
            stars[index].tintColor = .black
        }
        for index in intRating..<5 {
            stars[index].tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        }
    }

}

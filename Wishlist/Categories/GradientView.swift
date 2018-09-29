import UIKit

final class GradientView: UIView {

    var firstColor = UIColor(red: 255.0/255.0, green: 169.0/255.0, blue: 163.0/255.0, alpha: 1).cgColor
    var secondColor = UIColor(red: 194.0/255.0, green: 87.0/255.0, blue: 245.0/255.0, alpha: 1).cgColor
    var startPoint = CGPoint(x: 0, y: 0)
    var endPoint = CGPoint(x: 1, y: 1)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    func setupView() {
        autoresizingMask = [.flexibleWidth, .flexibleHeight]

        guard let theLayer = self.layer as? CAGradientLayer else {
            return;
        }

        theLayer.colors = [firstColor,
                           secondColor]
        theLayer.startPoint = startPoint
        theLayer.endPoint = endPoint
        theLayer.locations = [0.0, 1.0]
        theLayer.frame = self.bounds
    }

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
}

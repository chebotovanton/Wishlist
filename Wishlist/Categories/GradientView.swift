import UIKit

class GradientView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private func setupView() {
        autoresizingMask = [.flexibleWidth, .flexibleHeight]

        guard let theLayer = self.layer as? CAGradientLayer else {
            return;
        }

        theLayer.colors = [UIColor(red: 255.0/255.0, green: 169.0/255.0, blue: 163.0/255.0, alpha: 1),
                           UIColor(red: 194.0/255.0, green: 87.0/255.0, blue: 245.0/255.0, alpha: 1)]
        theLayer.startPoint = CGPoint(x: 0, y: 0)
        theLayer.endPoint = CGPoint(x: 1, y: 1)
        theLayer.locations = [0.0, 1.0]
        theLayer.frame = self.bounds
    }

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
}

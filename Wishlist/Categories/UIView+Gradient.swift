import UIKit

extension UIView {
    public func addGradient(startColor: UIColor, endColor: UIColor) {
        // does this work fine on view frame change?
        let gl = CAGradientLayer()
        gl.startPoint = CGPoint(x: 0, y: 0)
        gl.endPoint = CGPoint(x: 1, y: 1)
        gl.locations = [0.0, 1.0]
        gl.colors = [startColor.cgColor, endColor.cgColor]
        gl.frame = frame
        layer.insertSublayer(gl, at: 0)
    }
}

import UIKit

extension UIView {
    
    func toAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }

    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { addSubview($0) }
    }

}

extension UILabel {
    convenience init(font customFont: Font, text: String) {
        self.init(frame: .zero)
        self.toAutoLayout()
        font = customFont.font
        textColor = customFont.color
        self.text = customFont.isUppercase ? text.uppercased() : text
    }
}

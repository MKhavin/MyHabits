import UIKit

extension UIFont {
    
    static func preferredFont(forTextStyle style: TextStyle,
                              withSize size: CGFloat,
                              withWeight weight: Weight = Weight.regular) -> UIFont {
        // Get the font at the default size and preferred weight
        let font = UIFont.systemFont(ofSize: size, weight: weight)
        
        // Setup the font to be auto-scalable
        let metrics = UIFontMetrics(forTextStyle: style)
        return metrics.scaledFont(for: font)
    }
    
}
    
struct Font {
    let font: UIFont
    let color: UIColor
    let isUppercase: Bool
    
    init(font: UIFont, color: UIColor, isUppercase: Bool = false) {
        self.font = font
        self.color = color
        self.isUppercase = isUppercase
    }
}

enum Fonts {
    static let body = Font(font: .preferredFont(forTextStyle: .body, withSize: 17),
                           color: .black)
    static let title3 = Font(font: .preferredFont(forTextStyle: .title3, withSize: 20, withWeight: .semibold),
                             color: .black)
    static let headLine = Font(font: .preferredFont(forTextStyle: .headline, withSize: 17, withWeight: .semibold),
                               color: .blue)
    static let footnoteUppercase = Font(font: .preferredFont(forTextStyle: .footnote, withSize: 13, withWeight: .semibold),
                                        color: .black,
                                        isUppercase: true)
    static let footnoteStatus = Font(font: .preferredFont(forTextStyle: .footnote, withSize: 13, withWeight: .semibold),
                                     color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.5))
    static let footnote = Font(font: .preferredFont(forTextStyle: .footnote, withSize: 13),
                               color: .systemGray)
    static let caption = Font(font: .preferredFont(forTextStyle: .caption1, withSize: 12),
                              color: .systemGray2)
}



import UIKit

class HabitDetailsViewCell: UITableViewCell {

    private enum LayoutConstants {
        static let cellTopBottomInset: CGFloat = 11
        static let cellLeadingTrailingInset: CGFloat = 16
    }
    
    lazy var label = UILabel(font: Fonts.body)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        accessoryType = .none
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor,
                                           constant: LayoutConstants.cellTopBottomInset),
            label.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor,
                                              constant: -LayoutConstants.cellTopBottomInset),
            label.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,
                                               constant: LayoutConstants.cellLeadingTrailingInset),
            label.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,
                                                constant: -LayoutConstants.cellLeadingTrailingInset)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    private let itemYInset: CGFloat = 10
    private let itemXInset: CGFloat = 12
    
    private var percentProgress: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        return numberFormatter.string(from: NSNumber(value: HabitsStore.shared.todayProgress)) ?? "0 %"
    }
    
    private lazy var progressView: UIProgressView = {
        let view = UIProgressView(progressViewStyle: .bar)
        view.setProgress(GlobalConstants.habitsStore.todayProgress, animated: true)
        view.trackTintColor = FontsColor.lightGray
        view.tintColor = FontsColor.purple
        view.toAutoLayout()
        return view
    }()
    
    private lazy var progressLabel: UILabel = {
        let view = UILabel(font: Fonts.footnoteStatus,
                text: percentProgress)
        view.textColor = FontsColor.gray
        return view
    }()
    
    private lazy var stackTitle: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.toAutoLayout()
        view.spacing = 20
        view.alignment = .fill
        
        let label = UILabel(font: Fonts.footnoteStatus,
                            text: "Все получится !")
        label.textColor = FontsColor.gray
        label.toAutoLayout()
        view.addArrangedSubview(label)
        
        view.addArrangedSubview(progressLabel)
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        addSubviews([stackTitle, progressView])
        setSubViewsLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSubViewsLayout() {
        NSLayoutConstraint.activate([
            stackTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: itemYInset),
            stackTitle.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: itemXInset),
            stackTitle.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -itemXInset),
            stackTitle.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: stackTitle.bottomAnchor, constant: itemYInset),
            progressView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: itemXInset),
            progressView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -itemXInset),
            progressView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -15)
        ])
    }
    
    func updateProgress() {
        progressLabel.text = percentProgress
        progressView.setProgress(GlobalConstants.habitsStore.todayProgress, animated: true)
    }
}

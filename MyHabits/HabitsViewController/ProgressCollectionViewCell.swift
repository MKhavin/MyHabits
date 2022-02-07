import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    /// Перечисление, в котором хранятся значения констант AutoLayout
    private enum LayoutConstants {
        static let topBottomInset: CGFloat = 10
        static let leadingTrailingInset: CGFloat = 12
        static let progressBottomInset: CGFloat = -15
        static let stackHeight: CGFloat = 20
        static let stackSpacing: CGFloat = 18
    }
    
    /// Переменная, которая возвращает текущий прогресс в процентном соотношении
    private var percentProgress: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        return numberFormatter.string(from: NSNumber(value: HabitsStore.shared.todayProgress)) ?? "0 %"
    }
    
    // MARK: - UI elements
    
    /// Элемент, который отображает текущий прогресс
    private lazy var progressView: UIProgressView = {
        let view = UIProgressView(progressViewStyle: .bar)
        view.setProgress(GlobalConstants.habitsStore.todayProgress, animated: true)
        view.trackTintColor = FontsColor.lightGray
        view.tintColor = FontsColor.purple
        view.toAutoLayout()
        return view
    }()
    
    /// Элемент, который отбражает текущий прогресс в процентном соотношении
    private lazy var progressLabel: UILabel = {
        let view = UILabel(font: Fonts.footnoteStatus,
                           text: percentProgress)
        view.textColor = FontsColor.gray
        return view
    }()
    
    //Группа, которая содержит в себе мотивирующий слоган и текущий прогресс в виде процентного соотношения
    private lazy var stackTitle: UIStackView = {
        let view = UIStackView()
        view.toAutoLayout()
        view.axis = .horizontal
        view.spacing = LayoutConstants.stackSpacing
        
        let label = UILabel(font: Fonts.footnoteStatus,
                            text: "Все получится !")
        label.toAutoLayout()
        label.textColor = FontsColor.gray
        
        view.addArrangedSubview(label)
        view.addArrangedSubview(progressLabel)
        
        return view
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        addSubviews([stackTitle, progressView])
        setSubViewsLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Процедура, которая задает расположение элементов.
    func setSubViewsLayout() {
        NSLayoutConstraint.activate([
            stackTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,
                                            constant: LayoutConstants.topBottomInset),
            stackTitle.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
                                                constant: LayoutConstants.leadingTrailingInset),
            stackTitle.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
                                                 constant: -LayoutConstants.leadingTrailingInset),
            stackTitle.heightAnchor.constraint(equalToConstant: LayoutConstants.stackHeight)
        ])
        
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: stackTitle.bottomAnchor,
                                              constant: LayoutConstants.topBottomInset),
            progressView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
                                                  constant: LayoutConstants.leadingTrailingInset),
            progressView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
                                                   constant: -LayoutConstants.leadingTrailingInset),
            progressView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,
                                                 constant: LayoutConstants.progressBottomInset)
        ])
    }
    
    /// Процедура обновления текущего прогресса
    func updateProgress() {
        progressLabel.text = percentProgress
        progressView.setProgress(GlobalConstants.habitsStore.todayProgress, animated: true)
    }
}

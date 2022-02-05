import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    /// Перечисление с константами для AutoLayout
    private enum LayoutConstants: CGFloat {
        case deafultValue = 20
        case titleWidth = 220
        case widthHeightCheckButton = 38
    }
    
    /// Текущая привычка в коллекции
    private var habitData: Habit?
    
    // MARK: - UI elements
    
    /// Кнопка подтверждения
    private lazy var checkButton: UIButton = {
        let view = UIButton()
        view.toAutoLayout()
        view.layer.cornerRadius = 18
        view.layer.borderWidth = 2
        view.clipsToBounds = true
        view.backgroundColor = .systemBackground
        view.addTarget(self, action: #selector(trackHabit), for: .touchUpInside)
        return view
    }()
    
    /// Имя привычки
    private lazy var titleLabel: UILabel = {
        let view = UILabel(font: Fonts.headLine)
        view.numberOfLines = 2
        return view
    }()
    
    /// Детальная информация(время) о привычке
    private lazy var infoLabel: UILabel = {
        let view = UILabel(font: Fonts.caption)
        view.textColor = FontsColor.lightGray
        return view
    }()
    
    /// Информация о кол-ве подтверждений за весь период
    private lazy var countLabel: UILabel = {
        let view = UILabel(font: Fonts.footnote)
        view.textColor = FontsColor.gray
        return view
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        addSubviews([
            checkButton,
            titleLabel,
            infoLabel,
            countLabel
        ])
        setSubViewsLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Процедура задания расположения элементов
    private func setSubViewsLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: LayoutConstants.deafultValue.rawValue),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: LayoutConstants.deafultValue.rawValue),
            titleLabel.widthAnchor.constraint(equalToConstant: LayoutConstants.titleWidth.rawValue)
        ])
        
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            infoLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: LayoutConstants.deafultValue.rawValue)
        ])
        
        NSLayoutConstraint.activate([
            countLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -LayoutConstants.deafultValue.rawValue),
            countLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: LayoutConstants.deafultValue.rawValue)
        ])
        
        NSLayoutConstraint.activate([
            checkButton.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            checkButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -LayoutConstants.deafultValue.rawValue),
            checkButton.widthAnchor.constraint(equalToConstant: LayoutConstants.widthHeightCheckButton.rawValue),
            checkButton.heightAnchor.constraint(equalToConstant: LayoutConstants.widthHeightCheckButton.rawValue)
        ])
    }
    
    /// Процедура, которая заполняет данными элементы
    private func setSubViewsAppearance(by habit: Habit) {
        checkButton.layer.borderColor = habit.color.cgColor
        
        if habit.isAlreadyTakenToday {
            checkButton.backgroundColor = habit.color
            checkButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
            checkButton.tintColor = .systemBackground
        } else {
            checkButton.backgroundColor = .systemBackground
            checkButton.setImage(nil, for: .normal)
        }
        
        titleLabel.textColor = habit.color
        titleLabel.text = habit.name
        
        infoLabel.text = habit.dateString
        
        countLabel.text = "Счётчик: \(habit.trackDates.count)"
    }
    
    /// Процедура, которая получает данные привычки
    func setCell(data: Habit) {
        habitData = data
        
        guard let unpackedData = habitData else {
            return
        }
        
        setSubViewsAppearance(by: unpackedData)
    }
    
    // MARK: - Target's funcs
    
    /// Процедура обработки подтверждения
    @objc func trackHabit(_ sender: UIButton) {
        guard let unpackedData = habitData, !unpackedData.isAlreadyTakenToday else {
            return
        }
        
        GlobalConstants.habitsStore.track(unpackedData)
        setSubViewsAppearance(by: unpackedData)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: GlobalConstants.NotificationsIdentifiers.updateProgress.rawValue),
                                        object: nil)
    }
}

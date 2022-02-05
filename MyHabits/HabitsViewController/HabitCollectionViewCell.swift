import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    private var habitData: Habit?
    
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
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel(font: Fonts.headLine,
                           text: "")
        view.numberOfLines = 2
        return view
    }()
    
    private lazy var infoLabel: UILabel = {
        let view = UILabel(font: Fonts.caption,
                           text: "")
        view.textColor = FontsColor.lightGray
        return view
    }()
    
    private lazy var countLabel: UILabel = {
        let view = UILabel(font: Fonts.footnote,
                           text: "")
        view.textColor = FontsColor.gray
        return view
    }()
        
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
    
    private func setSubViewsLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(equalToConstant: 220)
        ])
        
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            infoLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            countLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            countLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            checkButton.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            checkButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            checkButton.widthAnchor.constraint(equalToConstant: 38),
            checkButton.heightAnchor.constraint(equalToConstant: 38)
        ])
    }
    
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
    
    func setCell(data: Habit) {
        habitData = data
        
        guard let unpackedData = habitData else {
            return
        }
        
        setSubViewsAppearance(by: unpackedData)
    }
    
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

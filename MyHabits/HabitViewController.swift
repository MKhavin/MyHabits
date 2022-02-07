import UIKit

class HabitViewController: UIViewController {
    private let habit: Habit?
    private let colorPickerSize: CGFloat = 30
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .autoupdatingCurrent
        formatter.timeStyle = .short
        return formatter
    }()
    
    // MARK: - UI elements
    
    private lazy var cancelButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        button.tintColor = FontsColor.purple
        return button
    }()
    
    private lazy var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        button.tintColor = FontsColor.purple
        return button
    }()
    
    private lazy var colorPicker: UIButton = {
        let view = UIButton()
        view.layer.cornerRadius = 15
        view.backgroundColor = .orange
        view.clipsToBounds = true
        view.toAutoLayout()
        view.addTarget(self, action: #selector(selectColor), for: .touchUpInside)
        return view
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let view = UIDatePicker()
        view.datePickerMode = .time
        view.date = Date()
        view.preferredDatePickerStyle = .wheels
        view.locale = .autoupdatingCurrent
        view.toAutoLayout()
        view.addTarget(self, action: #selector(setDate), for: .valueChanged)
        return view
    }()
    
    private lazy var habitNameHeader = UILabel(font: Fonts.footnoteUppercase, text: "название")
    
    private lazy var colorPickerHeader = UILabel(font: Fonts.footnoteUppercase, text: "цвет")
    
    private lazy var timeHeader = UILabel(font: Fonts.footnoteUppercase, text: "время")
    
    private lazy var timeInfoHeader = UILabel(font: Fonts.body, text: "Каждый день в")
    
    private lazy var habitName: UITextField = {
        let view = UITextField()
        view.toAutoLayout()
        view.font = Fonts.headLine.font
        view.textColor = Fonts.headLine.color
        view.tintColor = Fonts.body.color
        view.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        return view
    }()
    
    private lazy var timeInfo: UILabel = {
        let view = UILabel(font: Fonts.body, text: "\(dateFormatter.string(from: datePicker.date))")
        view.textColor = FontsColor.purple
        return view
    }()
    
    private lazy var deleteButton: UIButton = {
        let view = UIButton()
        view.setTitle("Удалить привычку", for: .normal)
        view.setTitleColor(.red, for: .normal)
        view.toAutoLayout()
        view.addTarget(self, action: #selector(deleteHabit), for: .touchUpInside)
        return view
    }()
    
    // MARK: - Lifecycle
    
    init(habit: Habit? = nil) {
        self.habit = habit
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setHabitData()
        
        view.backgroundColor = .systemBackground
        view.addSubviews([
            habitNameHeader, habitName, colorPickerHeader,
            colorPicker, timeHeader, timeInfoHeader,
            timeInfo, datePicker
        ])
        
        if habit != nil {
            view.addSubview(deleteButton)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
    }
    
    override func viewWillLayoutSubviews() {
        setSubViewsLayout()
    }

    /// Процедура, которая заполняет данные текущей привычки
    private func setHabitData() {
        guard let data = habit else {
            return
        }
        
        colorPicker.backgroundColor = data.color
        datePicker.date = data.date
        habitName.text = data.name
    }
    
    /// Процедура для формирования navigationBar
    private func setNavigationBar() {
        navigationItem.title = (habit == nil) ? "Создать" : "Править"
        navigationItem.setLeftBarButton(cancelButton, animated: false)
        navigationItem.setRightBarButton(saveButton, animated: false)
    }
    
    /// Процедура, которая задает AutoLayout constraints
    private func setSubViewsLayout() {
        NSLayoutConstraint.activate([
            habitNameHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                constant: GlobalConstants.navBarTopInset),
            habitNameHeader.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                    constant: GlobalConstants.subViewsBorderInset),
            habitNameHeader.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                     constant: -GlobalConstants.subViewsBorderInset)
        ])
        
        NSLayoutConstraint.activate([
            habitName.topAnchor.constraint(equalTo: habitNameHeader.bottomAnchor,
                                          constant: GlobalConstants.groupItemTopInset),
            habitName.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                              constant: GlobalConstants.subViewsBorderInset),
            habitName.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                               constant: -GlobalConstants.subViewsBorderInset)
        ])
        
        NSLayoutConstraint.activate([
            colorPickerHeader.topAnchor.constraint(equalTo: habitName.bottomAnchor,
                                          constant: GlobalConstants.groupTopInset),
            colorPickerHeader.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                              constant: GlobalConstants.subViewsBorderInset),
            colorPickerHeader.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                               constant: -GlobalConstants.subViewsBorderInset)
        ])
        
        NSLayoutConstraint.activate([
            colorPicker.topAnchor.constraint(equalTo: colorPickerHeader.bottomAnchor,
                                             constant: GlobalConstants.groupItemTopInset),
            colorPicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                 constant: GlobalConstants.subViewsBorderInset),
            colorPicker.widthAnchor.constraint(equalToConstant: colorPickerSize),
            colorPicker.heightAnchor.constraint(equalToConstant: colorPickerSize)
        ])
        
        NSLayoutConstraint.activate([
            timeHeader.topAnchor.constraint(equalTo: colorPicker.bottomAnchor,
                                          constant: GlobalConstants.groupTopInset),
            timeHeader.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                              constant: GlobalConstants.subViewsBorderInset),
            timeHeader.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                               constant: -GlobalConstants.subViewsBorderInset)
        ])
        
        NSLayoutConstraint.activate([
            timeInfoHeader.topAnchor.constraint(equalTo: timeHeader.bottomAnchor,
                                          constant: GlobalConstants.groupItemTopInset),
            timeInfoHeader.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                              constant: GlobalConstants.subViewsBorderInset)
        ])
        
        NSLayoutConstraint.activate([
            timeInfo.topAnchor.constraint(equalTo: timeHeader.bottomAnchor,
                                          constant: GlobalConstants.groupItemTopInset),
            timeInfo.leadingAnchor.constraint(equalTo: timeInfoHeader.trailingAnchor,
                                              constant: GlobalConstants.subViewsBorderInset)
        ])
        
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: timeInfoHeader.bottomAnchor,
                                          constant: GlobalConstants.groupItemTopInset),
            datePicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                              constant: GlobalConstants.subViewsBorderInset),
            datePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                               constant: -GlobalConstants.subViewsBorderInset)
        ])
        
        if habit != nil {
            NSLayoutConstraint.activate([
                deleteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -18),
                deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        }
    }
    
    // MARK: - Target's funcs
    
    /// Процедура создания/сохранения данных привычки
    private func saveChanges() {
        if habit == nil {
            let newHabit = Habit(name: habitName.text ?? "",
                                 date: datePicker.date,
                                 color: colorPicker.backgroundColor ?? .orange)
            GlobalConstants.habitsStore.habits.append(newHabit)
        } else {
            habit?.color = colorPicker.backgroundColor ?? .orange
            habit?.date = datePicker.date
            habit?.name = habitName.text ?? ""
            GlobalConstants.habitsStore.save()
        }
    }
    
    @objc func cancel() {
        dismiss(animated: true)
    }
    
    @objc func save() {
        saveChanges()
        let notification = (habit == nil) ? NSNotification.Name(rawValue: GlobalConstants.NotificationsIdentifiers.addHabit.rawValue)
        : NSNotification.Name(rawValue: GlobalConstants.NotificationsIdentifiers.habitDidEdit.rawValue)
        NotificationCenter.default.post(name: notification, object: nil)
        cancel()
    }
    
    @objc func selectColor(sender: UIButton) {
        let picker = UIColorPickerViewController()
        picker.delegate = self
        picker.selectedColor = colorPicker.backgroundColor ?? .orange
        present(picker, animated: true, completion: nil)
    }
    
    @objc func setDate(sender: UIDatePicker) {
        timeInfo.text = "\(dateFormatter.string(from: sender.date))"
    }
    
    @objc func deleteHabit(_ sender: UIButton) {
        let alert = UIAlertController(title: "Удалить привычку",
                                      message: "Вы хотите удалить привычку \"\(habit?.name ?? "")\" ?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Отмена", style: .cancel)
        let delete = UIAlertAction(title: "Удалить", style: .destructive) { _ in
            GlobalConstants.habitsStore.habits.removeAll() {
                $0 === self.habit
            }
            NotificationCenter.default.post(name: NSNotification.Name(GlobalConstants.NotificationsIdentifiers.deleteHabit.rawValue),
                                            object: nil)
            self.dismiss(animated: true)
        }
        
        alert.addActions([delete, cancel])
        present(alert, animated: true)
    }
}

// MARK: - ColorPicker delegate

extension HabitViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        colorPicker.backgroundColor = viewController.selectedColor
    }
    
}

import UIKit

class HabitViewController: UIViewController {

    private let isNewHabit: Bool
    
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
        view.toAutoLayout()
        view.addTarget(self, action: #selector(setData), for: .valueChanged)
        return view
    }()
    
    private lazy var textEditHeader = UILabel(font: Fonts.footnoteUppercase, text: "название")
    
    private lazy var colorPickerHeader = UILabel(font: Fonts.footnoteUppercase, text: "цвет")
    
    private lazy var timeHeader = UILabel(font: Fonts.footnoteUppercase, text: "время")
    
    private lazy var timeInfoHeader = UILabel(font: Fonts.body, text: "Каждый день в")
    
    private lazy var textEdit: UITextField = {
        let view = UITextField()
        view.toAutoLayout()
        view.font = Fonts.headLine.font
        view.textColor = Fonts.headLine.color
        view.tintColor = Fonts.body.color
        view.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        return view
    }()
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
    //        formatter.timeZone = TimeZone(abbreviation: "GMT+0:00") //Current time zone
            formatter.dateFormat = "HH:MM a"
        return formatter
    }()
    
    private lazy var timeInfo: UILabel = {
        let view = UILabel(font: Fonts.body, text: "\(dateFormatter.string(from: datePicker.date))")
        view.textColor = FontsColor.purple
        return view
    }()
    
    init(isNewHabit: Bool) {
        self.isNewHabit = isNewHabit
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubviews([
            textEditHeader, textEdit, colorPickerHeader,
            colorPicker, timeHeader, timeInfoHeader,
            timeInfo, datePicker
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
    }
    
    override func viewWillLayoutSubviews() {
        setSubViewsLayout()
    }

    private func setNavigationBar() {
        navigationItem.title = isNewHabit ? "Создать" : "Править"
        navigationItem.setLeftBarButton(cancelButton, animated: false)
        navigationItem.setRightBarButton(saveButton, animated: false)
    }
    
    private func setSubViewsLayout() {
        NSLayoutConstraint.activate([
            textEditHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                constant: GlobalConstants.navBarTopInset),
            textEditHeader.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                    constant: GlobalConstants.subViewsBorderInset),
            textEditHeader.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                     constant: -GlobalConstants.subViewsBorderInset)
        ])
        
        NSLayoutConstraint.activate([
            textEdit.topAnchor.constraint(equalTo: textEditHeader.bottomAnchor,
                                          constant: GlobalConstants.groupItemTopInset),
            textEdit.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                              constant: GlobalConstants.subViewsBorderInset),
            textEdit.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                               constant: -GlobalConstants.subViewsBorderInset)
        ])
        
        NSLayoutConstraint.activate([
            colorPickerHeader.topAnchor.constraint(equalTo: textEdit.bottomAnchor,
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
            colorPicker.widthAnchor.constraint(equalToConstant: 30),
            colorPicker.heightAnchor.constraint(equalToConstant: 30)
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
    }
    
    @objc func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func save() {
        let newHabit = Habit(name: textEdit.text ?? "",
                             date: datePicker.date,
                             color: colorPicker.backgroundColor ?? .orange)
        let store = HabitsStore.shared
        store.habits.append(newHabit)
        cancel()
    }
    
    @objc func selectColor(sender: UIButton) {
        let picker = UIColorPickerViewController()
        picker.delegate = self
        picker.selectedColor = colorPicker.backgroundColor ?? .orange
        present(picker, animated: true, completion: nil)
    }
    
    @objc func setData(sender: UIDatePicker) {
        timeInfo.text = "\(dateFormatter.string(from: sender.date))"
    }
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        colorPicker.backgroundColor = viewController.selectedColor
    }
    
}

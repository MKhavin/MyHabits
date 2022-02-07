import UIKit

class HabitDetailsViewController: UIViewController {
    
    let cellIdentifire = "DateCell"
    
    // MARK: - UI elements
    
    /// Таблица с датами чек-ин привычки
    private lazy var datesTable: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.toAutoLayout()
        view.backgroundColor = FontsColor.white
        view.dataSource = self
        view.delegate = self
        view.register(HabitDetailsViewCell.self, forCellReuseIdentifier: cellIdentifire)
        if #available(iOS 15, *) {
            view.sectionHeaderTopPadding = 0
        }
        return view
    }()
       
    /// Кнопка редактирования в navigationBar
    private lazy var editButton = UIBarButtonItem.init(barButtonSystemItem: .edit,
                                                       target: self,
                                                       action: #selector(editHabit))
    
    // MARK: - Data properties
    
    private var habit: Habit {
        GlobalConstants.habitsStore.habits[habitIndex]
    }
    private let habitIndex: Int
    private weak var parentView: HabitsViewController?
    
    // MARK: - Lifecycle
    
    init(habitIndex: Int, parentView: HabitsViewController?) {
        self.habitIndex = habitIndex
        self.parentView = parentView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = FontsColor.white
        view.addSubview(datesTable)
        setNavigationBar()
        setViewObservers()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            datesTable.topAnchor.constraint(equalTo: safeArea.topAnchor),
            datesTable.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            datesTable.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            datesTable.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    private func setNavigationBar() {
        title = habit.name
        navigationController?.navigationBar.tintColor = FontsColor.purple
        navigationItem.setRightBarButton(editButton, animated: false)
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setViewObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(habitDidEdit),
                                               name: NSNotification.Name(rawValue: GlobalConstants.NotificationsIdentifiers.habitDidEdit.rawValue),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(deleteHabit),
                                               name: NSNotification.Name(rawValue: GlobalConstants.NotificationsIdentifiers.deleteHabit.rawValue),
                                               object: nil)
    }
    
    // MARK: - Target's funcs
    
    @objc func editHabit(_ sender: UIBarButtonItem) {
        let navigationController = UINavigationController()
        let rootView = HabitViewController(habit: habit)
        navigationController.setViewControllers([rootView], animated: false)
        present(navigationController, animated: true)
    }
    
    @objc func habitDidEdit(_ sender: NSNotification) {
        parentView?.updateHabitInCollection(at: habitIndex)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func deleteHabit(_ sender: NSNotification) {
        parentView?.deleteHabitInCollection(at: habitIndex)
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - TableView data source

extension HabitDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        GlobalConstants.habitsStore.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire) as? HabitDetailsViewCell else {
            return HabitDetailsViewCell()
        }
        
        if GlobalConstants.habitsStore.habit(habit,
                                             isTrackedIn: GlobalConstants.habitsStore.dates[indexPath.row]) {
            cell.accessoryType = .checkmark
            cell.tintColor = FontsColor.purple
        } else {
            cell.accessoryType = .none
        }
        cell.label.text = GlobalConstants.habitsStore.trackDateString(forIndex: indexPath.row)
        
        return cell
    }
    
}

// MARK: - TableView delegate

extension HabitDetailsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "АКТИВНОСТЬ"
    }
    
}

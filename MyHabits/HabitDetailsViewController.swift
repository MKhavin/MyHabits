import UIKit

class HabitDetailsViewController: UIViewController {

    private lazy var datesTable: UITableView = {
        let view = UITableView(frame: .zero)
        view.toAutoLayout()
        view.backgroundColor = FontsColor.white
        view.dataSource = self
        view.delegate = self
        view.register(UITableViewCell.self, forCellReuseIdentifier: "DateCell")
        if #available(iOS 15, *) {
            view.sectionHeaderTopPadding = 0
        }
        return view
    }()
    
    private lazy var headerView: UITableViewHeaderFooterView = {
        let view = UITableViewHeaderFooterView()
        view.contentView.backgroundColor = FontsColor.white

        let label = UILabel(font: Fonts.footnoteUppercase, text: "Активность")
        label.toAutoLayout()
        label.textColor = UIColor(red: 60/255.0, green: 60/255.0, blue: 67/255.0, alpha: 0.6)
        view.contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.contentView.safeAreaLayoutGuide.topAnchor),
            label.bottomAnchor.constraint(equalTo: view.contentView.safeAreaLayoutGuide.bottomAnchor, constant: -7),
            label.leadingAnchor.constraint(equalTo: view.contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: view.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        return view
    }()
    
    private lazy var editButton = UIBarButtonItem.init(barButtonSystemItem: .edit,
                                                       target: self,
                                                       action: #selector(editHabit))
    
    private var habit: Habit {
        GlobalConstants.habitsStore.habits[rowIndex]
    }
    private let rowIndex: Int
    weak var parentView: HabitsViewController?
    
    init(habitIndex: Int) {
        rowIndex = habitIndex
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = FontsColor.white
        view.addSubview(datesTable)
        title = habit.name
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = FontsColor.purple
        
        navigationItem.setRightBarButton(editButton, animated: false)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(habitDidEdit),
                                               name: NSNotification.Name(rawValue: "HabitDidEdit"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(deleteHabit),
                                               name: NSNotification.Name(rawValue: "DeleteHabit"),
                                               object: nil)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            datesTable.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 22),
            datesTable.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            datesTable.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            datesTable.heightAnchor.constraint(equalToConstant: 44 * CGFloat(GlobalConstants.habitsStore.dates.count + 1))
        ])
    }
    
    @objc func editHabit(_ sender: UIBarButtonItem) {
        let navigationController = UINavigationController()
        navigationController.setViewControllers([HabitViewController(isNewHabit: false, habit: habit)], animated: false)
        present(navigationController, animated: true)
    }
    
    @objc func habitDidEdit(_ sender: NSNotification) {
        parentView?.updateHabit(at: rowIndex)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func deleteHabit(_ sender: NSNotification) {
        parentView?.deleteHabit(at: rowIndex)
        navigationController?.popViewController(animated: true)
    }
}

extension HabitDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        GlobalConstants.habitsStore.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell") else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        
        if GlobalConstants.habitsStore.habit(habit,
                                             isTrackedIn: GlobalConstants.habitsStore.dates[indexPath.row]) {
            cell.accessoryType = .checkmark
            cell.tintColor = FontsColor.purple
        } else {
            cell.accessoryType = .none
        }
        
        let cellLabel = UILabel(font: Fonts.body, text: (GlobalConstants.habitsStore.trackDateString(forIndex: indexPath.row) ?? ""))
        cell.contentView.addSubview(cellLabel)
        NSLayoutConstraint.activate([
            cellLabel.topAnchor.constraint(equalTo: cell.contentView.safeAreaLayoutGuide.topAnchor, constant: 11),
            cellLabel.bottomAnchor.constraint(equalTo: cell.contentView.safeAreaLayoutGuide.bottomAnchor, constant: -11),
            cellLabel.leadingAnchor.constraint(equalTo: cell.contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            cellLabel.trailingAnchor.constraint(equalTo: cell.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        
        return cell
    }
    
}

extension HabitDetailsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerView
    }
    
}

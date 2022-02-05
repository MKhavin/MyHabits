import UIKit

class HabitsViewController: UIViewController {

    private enum CollectionViewIdentifiers: String {
        case progressCell = "Progress cell"
        case habitCell = "Habit cell"
    }
        
    private lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addHabit))
        button.tintColor = FontsColor.purple
        return button
    }()
    
    private lazy var habitsCollection: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.delegate = self
        view.dataSource = self
        view.toAutoLayout()
        view.backgroundColor = FontsColor.white
        view.register(ProgressCollectionViewCell.self,
                      forCellWithReuseIdentifier: CollectionViewIdentifiers.progressCell.rawValue)
        view.register(HabitCollectionViewCell.self,
                      forCellWithReuseIdentifier: CollectionViewIdentifiers.habitCell.rawValue)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.updateHabitsProgress),
                                               name: NSNotification.Name(GlobalConstants.NotificationsIdentifiers.updateProgress.rawValue),
                                               object: nil)
        return view
    }()
        
    private var progressCell: ProgressCollectionViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(habitsCollection)
        setViewObservers()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        NSLayoutConstraint.activate([
            habitsCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            habitsCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            habitsCollection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            habitsCollection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNavigationBar()
    }

    private func setNavigationBar() {
        navigationItem.setRightBarButton(addButton, animated: false)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        navigationItem.title = "Сегодня"
    }
     
    private func setViewObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.addHabitToCollection),
                                               name: NSNotification.Name(GlobalConstants.NotificationsIdentifiers.addHabit.rawValue),
                                               object: nil)
    }
    
    func updateHabit(at item: Int) {
        habitsCollection.reloadItems(at: [IndexPath(item: item, section: 1)])
    }
    
    func deleteHabit(at item: Int) {
        habitsCollection.deleteItems(at: [IndexPath(item: item, section: 1)])
    }
    
    @objc func addHabit() {
        let navigationController = UINavigationController()
        navigationController.setViewControllers([HabitViewController(isNewHabit: true)], animated: false)
        present(navigationController, animated: true)
    }
    
    @objc func addHabitToCollection(_ sender: NSNotification) {
        habitsCollection.insertItems(at: [
            IndexPath(item: GlobalConstants.habitsStore.habits.count - 1,
                      section: 1)
        ])
        updateHabitsProgress()
    }
    
    @objc func updateHabitsProgress() {
        guard progressCell != nil else {
            return
        }
        
        progressCell!.updateProgress()
    }
}

extension HabitsViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        default: return GlobalConstants.habitsStore.habits.count
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewIdentifiers.progressCell.rawValue, for: indexPath) as? ProgressCollectionViewCell else {
                return ProgressCollectionViewCell()
            }
            
            if progressCell == nil {
                progressCell = cell
            }
            
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewIdentifiers.habitCell.rawValue, for: indexPath) as? HabitCollectionViewCell else {
                return HabitCollectionViewCell()
            }
            
            cell.setCell(data: GlobalConstants.habitsStore.habits[indexPath.item])
            return cell
        }
    }
    
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 0: return UIEdgeInsets(top: GlobalConstants.navBarTopInset, left: GlobalConstants.subViewsBorderInset,
                                    bottom: GlobalConstants.cellTopBottomInset * 2, right: GlobalConstants.subViewsBorderInset)
        default: return UIEdgeInsets(top: GlobalConstants.cellTopBottomInset, left: GlobalConstants.subViewsBorderInset,
                                     bottom: GlobalConstants.cellTopBottomInset, right: GlobalConstants.subViewsBorderInset)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - GlobalConstants.subViewsBorderInset * 2).rounded()
        
        switch indexPath.section {
        case 0: return CGSize(width: width, height: 60)
        default: return CGSize(width: width, height: 130)
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.layer.cornerRadius = 8
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let habitDetailsView = HabitDetailsViewController(habitIndex: indexPath.item)
        habitDetailsView.parentView = self
        navigationController?.pushViewController(habitDetailsView, animated: true)
    }
}

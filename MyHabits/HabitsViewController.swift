import UIKit

class HabitsViewController: UIViewController {

    private enum CollectionViewIdentifiers: String {
        case progressCell = "Progress cell"
        case habitCell = "Habit cell"
    }
    
    private lazy var addbutton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addHabit))
        button.tintColor = FontsColor.purple
        return button
    }()
    
//    private lazy var habitsCollection: UICollectionView = {
//        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
//        view.delegate = self
//        view.dataSource = self
//        view.toAutoLayout()
//        view.backgroundColor = FontsColor.lightGray
//        view.register(ProgressCollectionViewCell.self,
//                      forCellWithReuseIdentifier: CollectionViewIdentifiers.progressCell.rawValue)
//        view.register(HabitCollectionViewCell.self,
//                      forCellWithReuseIdentifier: CollectionViewIdentifiers.habitCell.rawValue)
//        return view
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        view.addSubview(habitsCollection)
    }
    
    override func viewWillLayoutSubviews() {
//        NSLayoutConstraint.activate([
//            habitsCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
//                                                  constant: GlobalConstants.navBarTopInset),
//            habitsCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            habitsCollection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
//                                                      constant: GlobalConstants.subViewsBorderInset),
//            habitsCollection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
//                                                       constant: -GlobalConstants.subViewsBorderInset)
//        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.setRightBarButton(addbutton, animated: false)
    }

    @objc func addHabit(sender: UIButton) {
        let navController = UINavigationController()
        navController.setViewControllers([HabitViewController(isNewHabit: true)], animated: false)
        present(navController, animated: true) {
            
        }
    }
}

//extension HabitsViewController: UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        2
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        UICollectionViewCell()
//    }
//
//}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    
}

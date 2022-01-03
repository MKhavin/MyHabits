import UIKit

class TabBarController: UITabBarController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        tabBar.tintColor = FontsColor.purple
        if #available(iOS 15, *) {
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let habitsNavController = UINavigationController()
        habitsNavController.tabBarItem.title = "Привычки"
        habitsNavController.tabBarItem.image = UIImage(systemName: "list.dash")
        
        let infoNavigationController = UINavigationController()
        infoNavigationController.setViewControllers([InfoViewController()], animated: false)
        infoNavigationController.tabBarItem.title = "Информация"
        infoNavigationController.tabBarItem.image = UIImage(systemName: "info.circle.fill")
        
        setViewControllers([habitsNavController, infoNavigationController], animated: false)
    }

}

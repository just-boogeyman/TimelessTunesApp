import UIKit

enum TabBarItem {
	case homeVC
	case favoriteVC
	
	var title: String {
		switch self {
		case .homeVC: return Constants.homeTitle
		case .favoriteVC: return Constants.favoriteTitle
		}
	}
	
	var icon: UIImage? {
		switch self {
		case .homeVC: return UIImage(systemName: Constants.homeIcon)
		case .favoriteVC: return UIImage(systemName: Constants.favoriteIcon)
		}
	}
	
	static let allTabBarItems = [homeVC, favoriteVC]
}

// MARK: - MusicTabBarController
final class MusicTabBarController: UITabBarController {
	private let dataSource: [TabBarItem] = [
		.homeVC, .favoriteVC
	]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupTabBar()
	}
}

// MARK: - Private Methods
private extension MusicTabBarController {
	func setupTabBar() {
		let controllers: [UINavigationController] = TabBarItem.allTabBarItems.map { item in
			getTabBarController(item)
		}
		setViewControllers(controllers, animated: true)
	}
	
	func getTabBarController(_ item: TabBarItem) -> UINavigationController {
		let navController = UINavigationController()
		navController.navigationBar.prefersLargeTitles = true
		
		let appearance = UINavigationBarAppearance()
		appearance.configureWithOpaqueBackground()
		appearance.backgroundColor = UIColor(resource: .background)
		
		appearance.titleTextAttributes = [
			.foregroundColor: UIColor(resource: .textPrimary),
			.font: UIFont.systemFont(ofSize: 18, weight: .bold)
		]
		
		appearance.largeTitleTextAttributes = [
			.foregroundColor: UIColor(resource: .textPrimary),
			.font: UIFont.systemFont(ofSize: 34, weight: .bold)
		]
		
		navController.navigationBar.standardAppearance = appearance
		navController.navigationBar.scrollEdgeAppearance = appearance
		
		navController.tabBarItem.title = item.title
		navController.tabBarItem.image = item.icon
		
		return navController
	}
}

// MARK: - Constants
private extension TabBarItem {
	enum Constants {
		static let homeTitle = "Поиск"
		static let favoriteTitle = "Favorite"
		
		static let homeIcon = "list.bullet.rectangle.portrait"
		static let favoriteIcon = "heart"
	}
}

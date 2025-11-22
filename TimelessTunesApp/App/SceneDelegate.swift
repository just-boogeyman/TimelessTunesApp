
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?
	private let storageManager = CoreDataManager()
	private let allTabBarItems = TabBarItem.allTabBarItems

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }

		window = UIWindow(windowScene: windowScene)
		
		let tabBarController = MusicTabBarController()
		
		tabBarController.viewControllers?.enumerated().forEach{ index, vc in
			guard let navVC = vc as? UINavigationController else { return }
			pushViewController(index: index, controller: navVC)
		}
		
		window?.rootViewController = UINavigationController(rootViewController: tabBarController)

		window?.makeKeyAndVisible()
	}
}

private extension SceneDelegate {
	func pushViewController(index: Int, controller: UINavigationController) {

		switch allTabBarItems[index] {
		case .homeVC:
			let router = HomeRouter()
			let networkService = NetworkService()
			let viewController = HomeAssembly.build(
				dependencies: .init(
					networkService: networkService,
					storageManager: storageManager,
					router: router
				)
			)
			router.setCurrentViewController(viewController: viewController)
			controller.pushViewController(viewController, animated: false)
		case .favoriteVC:
			let router = FavoriteRouter()
			let viewController = FavoriteAssembly.build(
				dependencies: .init(
					storageManager: storageManager,
					router: router
				)
			)
			router.setCurrentViewController(viewController: viewController)
			controller.pushViewController(viewController, animated: false)
		}
	}
}

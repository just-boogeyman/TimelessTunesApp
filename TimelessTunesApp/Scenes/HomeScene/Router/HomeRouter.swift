
import UIKit

protocol BaseRouting {
	func setCurrentViewController(viewController: UIViewController)
}

protocol IHomeRouter {
	func next(items: [MediaItem], index: Int)
}

final class HomeRouter {
	private var currentController: UIViewController?
	private var nextController: UIViewController?
}

extension HomeRouter: BaseRouting {
	func setCurrentViewController(viewController: UIViewController) {
		self.currentController = viewController
	}
}

extension HomeRouter: IHomeRouter {
	func next(items: [MediaItem], index: Int) {
		let detailModule = DetailTrackAssembly.build(items: items, index: index)
		currentController?.present(detailModule, animated: true)
	}
}

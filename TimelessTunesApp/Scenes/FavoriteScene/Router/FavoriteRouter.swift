
import Foundation
import UIKit


protocol IFavoriteRouter {
	func next(items: [MediaItem], index: Int)
}

final class FavoriteRouter {
	private var currentController: UIViewController?
	private var nextController: UIViewController?
}

extension FavoriteRouter: BaseRouting {
	func setCurrentViewController(viewController: UIViewController) {
		self.currentController = viewController
	}
}

extension FavoriteRouter: IFavoriteRouter {
	func next(items: [MediaItem], index: Int) {
		let detailModule = DetailTrackAssembly.build(items: items, index: index)
		currentController?.present(detailModule, animated: true)
	}
}

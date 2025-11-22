
import Foundation

protocol IFavoritePresenter: AnyObject {
	func loadView(controller: IFavoriteViewController, view: IFavoriteContentView)
}

final class FavoritePresenter {
	
	private let storageManager: ICoreDataFavoriteManager
	private let router: IFavoriteRouter
	private weak var controller: IFavoriteViewController?
	private weak var view: IFavoriteContentView?

	init(
		router: IFavoriteRouter,
		storageManager: ICoreDataFavoriteManager
	) {
		self.router = router
		self.storageManager = storageManager
	}
}

private extension FavoritePresenter {
	
	func setupHandlers() {

	}
	
	
}

extension FavoritePresenter: IFavoritePresenter {
	func loadView(controller: IFavoriteViewController, view: IFavoriteContentView) {
		self.controller = controller
		self.view = view
		setupHandlers()
//		presentCompanies()
	}
}

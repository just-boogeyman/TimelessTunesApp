
import Foundation

enum FavoriteAssembly {
	
	struct Dependencies {
		let storageManager: ICoreDataFavoriteManager
		let router: IFavoriteRouter
	}
	
	static func build(dependencies: Dependencies) -> FavoriteViewController {
		

		let presenter = FavoritePresenter(router: dependencies.router, storageManager: dependencies.storageManager)
		let viewController = FavoriteViewController(presenter: presenter)
		
		return viewController
	}
}


import Foundation
import UIKit

enum HomeAssembly {
	
	struct Dependencies {
		let networkService: INetworkService
		let storageManager: ICoreDataHistoryManager
		let router: IHomeRouter
	}
	
	static func build(dependencies: Dependencies) -> HomeViewController {
		
		let interactor = HomeInteractor(
			networkService: dependencies.networkService,
			storageManager: dependencies.storageManager
		)
		let presenter = HomePresenter(interactor: interactor, router: dependencies.router)
		let viewController = HomeViewController(presenter: presenter)
		
		interactor.output = presenter
		return viewController
	}
}

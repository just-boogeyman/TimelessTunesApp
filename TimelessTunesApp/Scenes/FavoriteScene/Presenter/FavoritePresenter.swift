
import Foundation

protocol IFavoritePresenter: AnyObject {
	func loadView(controller: IFavoriteViewController, view: IFavoriteContentView)
}

final class FavoritePresenter {
	
	private let storageManager: ICoreDataFavoriteManager
	private let router: IFavoriteRouter
	private weak var controller: IFavoriteViewController?
	private weak var view: IFavoriteContentView?
	
	private var items: [MediaItem] = []

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
		self.view?.deletedHandler = { [weak self] index in
			guard let self else { return }
			storageManager.deleteCompany(for: index)
			presentCompanies()
		}
		self.view?.nextHandler = { [weak self] index in
			guard let self else { return }
			router.next(items: items, index: index)
		}
		
		self.controller?.handlerUpdate = { [weak self] in
			guard let self else { return }
			presentCompanies()
		}
	}
	
	func presentCompanies() {
		let entities = storageManager.loadTracksFavorite()
		let tracks = entities.map {
			MediaItem(
				id: Int($0.id),
				artistName: $0.artistName,
				trackName: $0.trackName,
				artworkUrl: $0.artworkUrl,
				previewUrl: $0.previewUrl
			)
		}
		self.items = tracks
		let items = tracks.compactMap { FavoriteEntity(artistName: $0.artistName, trackName: $0.trackName) }
		view?.render(items: items)
	}
}

extension FavoritePresenter: IFavoritePresenter {
	func loadView(controller: IFavoriteViewController, view: IFavoriteContentView) {
		self.controller = controller
		self.view = view
		setupHandlers()
	}
}

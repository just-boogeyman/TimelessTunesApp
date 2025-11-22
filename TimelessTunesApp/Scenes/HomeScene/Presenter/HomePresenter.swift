
import Foundation

protocol IHomePresenter {
	func loadView(controller: IHomeViewController, view: IHomeContentView)
	func userDidEnterSearch(searchText: String)
	func loadHistory()
}

final class HomePresenter {
	
	private weak var controller: IHomeViewController?
	private weak var view: IHomeContentView?
	private let interactor: IHomeInteractorInput
	private let router: IHomeRouter
	
	private var items: [MediaItem] = []
	
	init(interactor: IHomeInteractorInput, router: IHomeRouter) {
		self.interactor = interactor
		self.router = router
	}
	
	private func cellViewModel(from track: MediaItem) -> HomeViewModel.Cell {
		HomeViewModel.Cell(iconUrlString: track.artworkUrl, trackName: track.trackName, artistName: track.artistName, previewUrl: track.previewUrl)
	}
	
	private func setHandlers() {
		view?.touchHandler = { [weak self] index in
			guard let self else { return }
			let track = items[index]
			interactor.saveTrackToHistory(track)
			router.next(items: items, index: index)
		}
	}
}

extension HomePresenter: IHomePresenter {
	func loadHistory() {
		interactor.loadHistoryTracks()
	}
	
	func userDidEnterSearch(searchText: String) {
		interactor.searchTracks(searchText: searchText)
	}
	
	func loadView(controller: IHomeViewController, view: IHomeContentView) {
		self.controller = controller
		self.view = view
		self.setHandlers()
	}
}

extension HomePresenter: IHomeInteractorOutput {
	func presentData(responce: [MediaItem]) {
		self.items = responce
		let cells = responce.map { cellViewModel(from: $0) }
		let viewModel = HomeViewModel(cells: cells)
		view?.displayData(viewModel: viewModel)
	}
	
	func didFail(error: Error) {
		print(error)
	}
}

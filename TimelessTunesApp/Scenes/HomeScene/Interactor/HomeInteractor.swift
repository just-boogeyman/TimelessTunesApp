
import Foundation


protocol IHomeInteractorInput {
	func searchTracks(searchText: String)
	func saveTrackToHistory(_ track: MediaItem)
	func loadHistoryTracks()
}

protocol IHomeInteractorOutput: AnyObject {
	func presentData(responce: [MediaItem])
	func didFail(error: Error)
}

final class HomeInteractor {
	
	private let networkService: INetworkService
	private let storageManager: ICoreDataHistoryManager
	weak var output: IHomeInteractorOutput?
	 
	init(networkService: INetworkService, storageManager: ICoreDataHistoryManager) {
		self.networkService = networkService
		self.storageManager = storageManager
	}
}

extension HomeInteractor: IHomeInteractorInput {
	func loadHistoryTracks() {
		let entities = storageManager.loadTracks()
		print(entities)
		let tracks = entities.map {
			MediaItem(
				id: Int($0.id),
				artistName: $0.artistName,
				trackName: $0.trackName,
				artworkUrl: $0.artworkUrl,
				previewUrl: $0.previewUrl
			)
		}
		output?.presentData(responce: tracks)
	}
	
	func saveTrackToHistory(_ track: MediaItem) {
		storageManager.saveTrack(value: track)
	}
	
	func searchTracks(searchText: String) {
		networkService.loadData(form: .basic, ITunesSearchResponse.self, string: searchText) { [weak self] result in
			guard let self else { return }
			switch result {
			case .success(let response):
				let entities = response.results.map { $0.toEntity() }
				output?.presentData(responce: entities)
			case .failure(let error):
				output?.didFail(error: error)
			}
		}
	}
}


import Foundation

final class DetailTrackInteractor {
	
	weak var output: IDetailTrackInteractorOutput?
	private var player: IPlayerManager
	private let playbackQueue: IPlaybackQueueManager
	
	private let items: [MediaItem]
	private let currentIndex: Int
	
	init(player: IPlayerManager, playbackQueue: IPlaybackQueueManager, items: [MediaItem], currentIndex: Int) {
		self.player = player
		self.playbackQueue = playbackQueue
		self.items = items
		self.currentIndex = currentIndex
		self.setHandlers()
	}
	
	private func setHandlers() {
		self.player.onPlayStateChanged = { [weak self] isPlaying in
			self?.output?.didChangePlayState(isPlaying: isPlaying)
		}
		self.player.onTimeUpdate = { [weak self] current, duration in
			self?.output?.didUpdateTime(current: current, duration: duration)
		}
	}
	
	private func startTrack(entity: DetailTrackEntity) {
		guard let url = URL(string: entity.previewUrl) else { return }
		player.load(url: url)
		player.play()
		output?.didLoadTrack(entity: entity)
	}
}

extension DetailTrackInteractor: IDetailTrackInteractorInput {
	
	func nextTrack() {
		guard let entity = playbackQueue.nextTrack() else { return }
		startTrack(entity: entity)
	}
	
	func previos() {
		guard let entity = playbackQueue.previousTrack() else { return }
		startTrack(entity: entity)
	}
	
	func setVolume(_ value: Float) {
		player.setVolume(value)
	}
	
	func seekTime(_ percentage: Float) {
		player.seekTime(percentage)
	}
	
	func loadTrack() {
		let tracks = items.map {
			DetailTrackEntity(
				iconUrlString: $0.artworkUrl,
				trackName: $0.trackName,
				artistName: $0.artistName,
				previewUrl: $0.previewUrl
			)
		}
		self.playbackQueue.setQueue(tracks, startAt: currentIndex)
		startTrack(entity: tracks[currentIndex])
	}
	
	func playPause() {
		player.togglePlayPause()
	}
}

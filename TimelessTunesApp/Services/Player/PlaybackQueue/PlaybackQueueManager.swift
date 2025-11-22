
import Foundation

final class PlaybackQueueManager {
	private var tracks: [DetailTrackEntity] = []
	private var currentIndex: Int = 0
	
	var currentTrack: DetailTrackEntity? {
		guard !tracks.isEmpty else { return nil }
		return tracks[currentIndex]
	}
}

extension PlaybackQueueManager: IPlaybackQueueManager {
	func setQueue(_ tracks: [DetailTrackEntity], startAt index: Int) {
		self.tracks = tracks
		self.currentIndex = index
	}
	
	func nextTrack() -> DetailTrackEntity? {
		guard !tracks.isEmpty else { return nil }
		currentIndex = (currentIndex + 1) % tracks.count
		return currentTrack
	}
	
	func previousTrack() -> DetailTrackEntity? {
		guard !tracks.isEmpty else { return nil }
		currentIndex = (currentIndex - 1 + tracks.count) % tracks.count
		return currentTrack
	}
}

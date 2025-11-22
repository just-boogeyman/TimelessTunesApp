
import Foundation

protocol IPlaybackQueueManager {
	var currentTrack: DetailTrackEntity? { get }
	
	func setQueue(_ tracks: [DetailTrackEntity], startAt index: Int)
	func nextTrack() -> DetailTrackEntity?
	func previousTrack() -> DetailTrackEntity?
}

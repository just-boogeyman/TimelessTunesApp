
import Foundation

protocol IPlayerManager {
	var onTimeUpdate: ((Double, Double) -> Void)? { get set }
	var onPlayStateChanged: ((Bool) -> Void)? { get set }
	func load(url: URL)
	func play()
	func pause()
	func seekTime(_ percentage: Float)
	func setVolume(_ value: Float)
	func togglePlayPause()
}

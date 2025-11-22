
import Foundation

protocol IDetailTrackInteractorInput {
	func loadTrack()
	func playPause()
	func seekTime(_ percentage: Float)
	func setVolume(_ value: Float)
	func nextTrack()
	func previos()
}

protocol IDetailTrackInteractorOutput: AnyObject {
	func didChangePlayState(isPlaying: Bool)
	func didLoadTrack(entity: DetailTrackEntity)
	func didUpdateTime(current: Double, duration: Double)
}


import Foundation
import AVKit

final class PlayerManager {
	private let player = AVPlayer()
	
	var onTimeUpdate: ((Double, Double) -> Void)?
	var onPlayStateChanged: ((Bool) -> Void)?

	private func observeTime() {
		let interval = CMTime(value: 1, timescale: 30)
		player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
			guard let self, let item = self.player.currentItem else { return }
			let current = CMTimeGetSeconds(time)
			let duration = CMTimeGetSeconds(item.duration)
			self.onTimeUpdate?(current, duration)
		}
	}
}

extension PlayerManager: IPlayerManager {
	func setVolume(_ value: Float) {
		player.volume = value
	}
	
	func load(url: URL) {
		let item = AVPlayerItem(url: url)
		player.replaceCurrentItem(with: item)
		observeTime()
	}
	
	func play() {
		player.play()
		onPlayStateChanged?(true)
	}
	
	func pause() {
		player.pause()
		onPlayStateChanged?(false)
	}
	
	func seekTime(_ percentage: Float) {
		guard let duration = player.currentItem?.duration else { return }
		let durationInSeconds = CMTimeGetSeconds(duration)
		let seekTimeUnSeconds = Float64(percentage) * durationInSeconds
		let seekTime = CMTimeMakeWithSeconds(seekTimeUnSeconds, preferredTimescale: 1)
		player.seek(to: seekTime)
	}
	
	func togglePlayPause() {
		player.timeControlStatus == .paused ? play() : pause()
	}
	
}

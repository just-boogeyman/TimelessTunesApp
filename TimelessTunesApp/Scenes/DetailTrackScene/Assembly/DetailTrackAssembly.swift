
import Foundation
import UIKit

enum DetailTrackAssembly {
	static func build(items: [MediaItem], index: Int) -> DetailTrackViewController {
		let player = PlayerManager()
		let playbackQueue = PlaybackQueueManager()
		
		let interactor = DetailTrackInteractor(
			player: player,
			playbackQueue: playbackQueue,
			items: items,
			currentIndex: index
		)
		let presenter = DetailTrackPresenter(interactor: interactor)
		let controller = DetailTrackViewController(presenter: presenter)
		interactor.output = presenter

		return controller
	}
}

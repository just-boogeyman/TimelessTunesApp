
import Foundation
import AVKit

protocol IDetailTrackPresenter {
	func loadView(controller: IDetailTrackViewController, view: IDetailTrackView)
}

final class DetailTrackPresenter {
	
	private weak var controller: IDetailTrackViewController?
	private weak var view: IDetailTrackView?
	private let interactor: IDetailTrackInteractorInput
		
	init(interactor: IDetailTrackInteractorInput) {
		self.interactor = interactor
	}
	
	private func setHandlers() {
		view?.handlerPlayPause = { [weak self] in
			guard let self else { return }
			interactor.playPause()
		}
		view?.handlerTimeSlider = { [weak self] percentage in
			guard let self else { return }
			interactor.seekTime(percentage)
		}
		view?.handlerValueSlider = { [weak self] value in
			guard let self else { return }
			interactor.setVolume(value)
		}
		view?.handlerNext = { [weak self] in
			guard let self else { return }
			interactor.nextTrack()
		}
		view?.handlerPrevious = { [weak self] in
			guard let self else { return }
			interactor.previos()
		}
	}
}

extension DetailTrackPresenter: IDetailTrackPresenter {
	func loadView(controller: IDetailTrackViewController, view: IDetailTrackView) {
		self.controller = controller
		self.view = view
		self.setHandlers()
		interactor.loadTrack()
	}
}

extension DetailTrackPresenter: IDetailTrackInteractorOutput {
	
	func didUpdateTime(current: Double, duration: Double) {
		guard duration > 0 else { return }
		let currentStr = current.toTime()
		let remainingStr = "-\((duration - current).toTime())"
		let slider = Float(current / duration)
		let time = TimeTrack(current: currentStr, duration: remainingStr, slider: slider)
		view?.updateTime(time: time)
	}
	
	func didChangePlayState(isPlaying: Bool) {
		view?.updatePlayState(isPlaying: isPlaying)
	}
	
	func didLoadTrack(entity: DetailTrackEntity) {
		let iconUrlString = entity.iconUrlString.replacingOccurrences(of: "100x100", with: "600x600")
		let viewModel = DetailViewModel(iconUrlString: iconUrlString, trackName: entity.trackName, artistName: entity.artistName)
		view?.configure(viewModel: viewModel)
	}
}

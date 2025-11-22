
import UIKit

protocol IDetailTrackView: UIView {
	var handlerPlayPause: (() -> Void)? { get set }
	var handlerTimeSlider: ((Float) -> Void)? { get set }
	var handlerValueSlider: ((Float) -> Void)? { get set }
	var handlerNext: (() -> Void)? { get set }
	var handlerPrevious: (() -> Void)? { get set }
	func configure(viewModel: DetailViewModel)
	func updatePlayState(isPlaying: Bool)
	func updateTime(time: TimeTrack)
}

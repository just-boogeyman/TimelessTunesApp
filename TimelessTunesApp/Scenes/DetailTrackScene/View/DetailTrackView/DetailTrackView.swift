
import UIKit
import SnapKit

final class DetailTrackView: UIView {
	var handlerPlayPause: (() -> Void)?
	var handlerTimeSlider: ((Float) -> Void)?
	var handlerValueSlider: ((Float) -> Void)?
	var handlerNext: (() -> Void)?
	var handlerPrevious: (() -> Void)?

	private var isScrubbing = false

	private let buttonClose = UIFactory.shared.makeCloseButton()
	private let mainStackView = UIFactory.shared.makeVStack(spacing: UIConstants.Layout.mainStackSpacing)
	private let trackImageView = TrackImageView(frame: .zero)

	private let sliderTimeStackView = UIFactory.shared.makeVStack(spacing: UIConstants.Layout.sliderStackSpacing)
	private let currentTimeSlider = UISlider()
	private let timeStackView = UIFactory.shared.makeHStack(distribution: .fillEqually)
	private let currentTimeLabel = UIFactory.shared.makeCurrentTimeLabel()
	private let durationTimeLabel = UIFactory.shared.makeDurationTimeLabel()

	private let titleStackView = UIFactory.shared.makeVStack()
	private let trackTitleLabel = UIFactory.shared.makeTrackTitleLabel()
	private let authorTitleLabel = UIFactory.shared.makeTrackTitleLabel()

	private let buttonStackView = UIFactory.shared.makeHStack(
		spacing: UIConstants.Layout.buttonStackSpacing, alignment: .center,
		distribution: .fillEqually
	)
	private let playPauseButton = UIFactory.shared.makeButton(image: UIImage(resource: .pause))
	private let nextButton = UIFactory.shared.makeButton(image: UIImage(resource: .right))
	private let previousButton = UIFactory.shared.makeButton(image: UIImage(resource: .left))

	private let volumeStackView = UIFactory.shared.makeHStack(spacing: UIConstants.Layout.volumeStackSpacing)
	private let volumeSlider = UISlider()
	private let minVolumeImage = UIFactory.shared.makeButton(image: UIImage(resource: .iconMin))
	private let maxVolumeImage = UIFactory.shared.makeButton(image: UIImage(resource: .iconMax))
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(viewModel: DetailViewModel) {
		trackTitleLabel.text = viewModel.trackName
		authorTitleLabel.text = viewModel.artistName
		trackImageView.setImage(urlString: viewModel.iconUrlString)
	}
}

private extension DetailTrackView {
	func setupView() {
		backgroundColor = .systemBackground
		setupActions()
		addSubviews()
		setupVolumeStackView()
		setupVolumeSlider()
		setupConstraints()
	}

	func addSubviews() {
		addSubview(mainStackView)
		mainStackView
			.addArrangedSubviews(
				buttonClose,
				trackImageView,
				sliderTimeStackView,
				titleStackView,
				buttonStackView,
				volumeStackView
			)
		sliderTimeStackView.addArrangedSubviews(currentTimeSlider, timeStackView)
		timeStackView.addArrangedSubviews(currentTimeLabel, durationTimeLabel)
		titleStackView.addArrangedSubviews(trackTitleLabel, authorTitleLabel)
		buttonStackView.addArrangedSubviews(previousButton, playPauseButton, nextButton)
		volumeStackView.addArrangedSubviews(minVolumeImage, volumeSlider, maxVolumeImage)
	}

	func setupVolumeStackView() {
		minVolumeImage.contentMode = .scaleAspectFit
		maxVolumeImage.contentMode = .scaleAspectFit
	}

	func setupVolumeSlider() {
		volumeSlider.value = UIConstants.Default.volume
		handlerValueSlider?(volumeSlider.value)
	}

	func setupConstraints() {
		mainStackView.snp.makeConstraints { make in
			make.top.equalTo(safeAreaLayoutGuide)
			make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(UIConstants.Layout.mainInset)
			make.bottom.equalTo(safeAreaLayoutGuide).inset(UIConstants.Layout.mainInset)
		}
		buttonClose.snp.makeConstraints { make in
			make.height.equalTo(UIConstants.Layout.closeButtonHeight)
		}
		trackImageView.snp.makeConstraints { make in
			make.height.equalTo(trackImageView.snp.width)
		}
		currentTimeSlider.snp.makeConstraints { make in
			make.height.equalTo(UIConstants.Layout.timeSliderHeight)
		}
		volumeSlider.snp.makeConstraints { make in
			make.height.equalTo(UIConstants.Layout.volumeSliderHeight)
		}
		minVolumeImage.snp.makeConstraints { make in
			make.width.height.equalTo(UIConstants.Layout.minMaxIconSize)
		}
		maxVolumeImage.snp.makeConstraints { make in
			make.width.height.equalTo(UIConstants.Layout.minMaxIconSize)
		}
	}
}

private extension DetailTrackView {
	func setupActions() {
		playPauseButton.addTarget(self, action: #selector(playPauseAction), for: .touchUpInside)
		currentTimeSlider.addTarget(self, action: #selector(sliderTouchDown), for: .touchDown)
		currentTimeSlider.addTarget(self, action: #selector(sliderTouchUp), for: [.touchUpInside, .touchUpOutside])
		volumeSlider.addTarget(self, action: #selector(handleVolumeSlider), for: .valueChanged)
		nextButton.addTarget(self, action: #selector(nextTrack), for: .touchUpInside)
		previousButton.addTarget(self, action: #selector(previousTrack), for: .touchUpInside)
	}

	@objc func sliderTouchDown() {
		isScrubbing = true
	}

	@objc func sliderTouchUp() {
		isScrubbing = false
		handlerTimeSlider?(currentTimeSlider.value)
	}

	@objc func handleCurrentTimerSlider() {
		let float = currentTimeSlider.value
		handlerTimeSlider?(float)
	}

	@objc func handleVolumeSlider() {
		handlerValueSlider?(volumeSlider.value)
	}

	@objc func previousTrack() {
		handlerPrevious?()
		trackImageView.animationNextPrevious(.previous)
	}

	@objc func nextTrack() {
		handlerNext?()
		trackImageView.animationNextPrevious(.next)
	}

	@objc func playPauseAction() {
		handlerPlayPause?()
	}
}

extension DetailTrackView: IDetailTrackView {
	func updateTime(time: TimeTrack) {
		guard !isScrubbing else { return }
		currentTimeLabel.text = time.current
		durationTimeLabel.text = time.duration
		currentTimeSlider.setValue(time.slider, animated: true)
	}

	func updatePlayState(isPlaying: Bool) {
		let imageName = isPlaying ? UIImage(resource: .pause) : UIImage(resource: .play)
		playPauseButton.setImage(imageName, for: .normal)
		isPlaying ? trackImageView.animateEnlarge() : trackImageView.animateReduce()
	}
}

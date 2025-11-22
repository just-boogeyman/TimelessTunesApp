
import UIKit

protocol ITrackCellViewModel {
	var iconUrlString: String? { get }
	var trackName: String { get }
	var artistName: String { get }
}

final class HomeCollectionViewCell: UICollectionViewCell {
	
	private let imageView = TrackImageView(frame: .zero)
	private let trackNameLabel = UIFactory.shared.makeLabel(
		font: Constants.Font.trackName,
		textColor: Constants.Color.textPrimary,
		numberOfLines: Constants.Layout.minNumberOfLines
	)
	private let artistNameLabel = UIFactory.shared.makeLabel(
		font: Constants.Font.artistName,
		textColor: Constants.Color.textPrimary,
		numberOfLines: Constants.Layout.maxNumberOfLines
	)
	private let stackView = UIFactory.shared.makeVStack(
		spacing: Constants.Layout.stackSpacing,
		distribution: .equalSpacing
	)

	private let executorLabel = UILabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure(viewModel: ITrackCellViewModel) {
		guard let iconUrlString = viewModel.iconUrlString else { return }
		imageView.setImage(urlString: iconUrlString)
		trackNameLabel.text = viewModel.trackName
		artistNameLabel.text = viewModel.artistName
	}
}

private extension HomeCollectionViewCell {
	
	func setupView() {
		backgroundColor = Constants.Color.background
		layer.cornerRadius = Constants.Layout.cornerRadius
		layer.shadowColor = Constants.Color.shadow
		layer.shadowOpacity = Constants.Layout.shadowOpacity
		layer.shadowOffset = Constants.Layout.shadowOffset
		layer.shadowRadius = Constants.Layout.shadowRadius
		
		setupStackView()
		setupLayout()
	}
	
	func setupStackView() {
		stackView.addArrangedSubviews(trackNameLabel, artistNameLabel)
	}
}

private extension HomeCollectionViewCell {
	func setupLayout() {
		contentView.addSubview(imageView)
		contentView.addSubview(stackView)
		
		imageView.snp.makeConstraints {
			$0.top.equalToSuperview().offset(Constants.Layout.contentInset)
			$0.leading.trailing.equalToSuperview().inset(Constants.Layout.contentInset)
			$0.height.equalTo(Constants.Layout.imageHeight)
		}
		
		stackView.snp.makeConstraints {
			$0.top.equalTo(imageView.snp.bottom).offset(Constants.Layout.contentInset)
			$0.leading.trailing.equalTo(imageView)
			$0.bottom.lessThanOrEqualToSuperview().offset(-Constants.Layout.contentInset)
		}
	}
}

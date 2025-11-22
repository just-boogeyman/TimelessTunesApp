
import UIKit

final class UIFactory {
	
	static let shared = UIFactory()
	private init() {}
		
	func makeVStack(
		spacing: CGFloat = 0,
		alignment: UIStackView.Alignment = .fill,
		distribution: UIStackView.Distribution = .fill
	) -> UIStackView {
		let stack = UIStackView()
		stack.axis = .vertical
		stack.spacing = spacing
		stack.alignment = alignment
		stack.distribution = distribution
		return stack
	}

	func makeHStack(
		spacing: CGFloat = 0,
		alignment: UIStackView.Alignment = .fill,
		distribution: UIStackView.Distribution = .fill
	) -> UIStackView {
		let stack = UIStackView()
		stack.axis = .horizontal
		stack.spacing = spacing
		stack.alignment = alignment
		stack.distribution = distribution
		return stack
	}
		
	func makeButton(image: UIImage) -> UIButton {
		let button = UIButton()
		button.setImage(image, for: .normal)
		return button
	}
	
	func makeLabel(font: UIFont, textColor: UIColor, numberOfLines: Int) -> UILabel {
		let label = UILabel()
		label.font = font
		label.textColor = textColor
		label.numberOfLines = numberOfLines
		return label
	}
	
	func makeCloseButton() -> UIButton {
		let button = UIButton()
		button.setImage(.init(systemName: "chevron.down"), for: .normal)
		button.tintColor = .label
		button.contentHorizontalAlignment = .center
		return button
	}
	
	func makeCurrentTimeLabel() -> UILabel {
		let label = UILabel()
		label.textAlignment = .left
		label.text = UIConstants.Default.timeStart
		label.font = .systemFont(ofSize: UIConstants.Font.timeLabel)
		return label
	}
	
	func makeDurationTimeLabel() -> UILabel {
		let label = UILabel()
		label.textAlignment = .right
		label.text = UIConstants.Default.timeUnknown
		label.font = .systemFont(ofSize: UIConstants.Font.timeLabel)
		return label
	}

	func makeTrackTitleLabel() -> UILabel {
		let label = UILabel()
		label.textAlignment = .center
		label.font = .systemFont(ofSize: UIConstants.Font.title, weight: .semibold)
		return label
	}
	
	func makeAuthorTitleLabel() -> UILabel {
		let label = UILabel()
		label.textAlignment = .center
		label.font = .systemFont(ofSize: UIConstants.Font.title, weight: .light)
		label.textColor = UIConstants.Colors.accent
		return label
	}
}


import UIKit
import SpringAnimation

final class TrackImageView: SpringImageView {
	
	enum Constants {
		static let cornerRadius: CGFloat = 12
		static let targetImageSize = CGSize(width: 300, height: 300)
		static let fadeDuration: CGFloat = 1.0

		static let animationForce: CGFloat = 1
		static let animationDuration: CGFloat = 1.0
		static let animationDelay: CGFloat = 0.3
		static let springDamping: CGFloat = 0.5
		static let springVelocity: CGFloat = 1.0
		static let animationOptions: UIView.AnimationOptions = .curveEaseInOut

		static let enlargeScale: CGFloat = 1.0
		static let reduceScale: CGFloat = 0.8
		static let delay: TimeInterval = 0
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupUI()
	}
	
	private func setupUI() {
		contentMode = .scaleAspectFill
		clipsToBounds = true
		layer.cornerRadius = Constants.cornerRadius
	}
}

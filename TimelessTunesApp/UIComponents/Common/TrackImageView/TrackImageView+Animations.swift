
import UIKit
import SpringAnimation

extension TrackImageView {
	
	func animationNextPrevious(_ nextPrevious: NextPrevious) {
		self.animation = nextPrevious.animation
		self.force = Constants.animationForce
		self.duration = CGFloat(Constants.animationDuration)
		self.delay = CGFloat(Constants.animationDelay)
		self.animate()
	}
	
	private func animateScale(to scale: CGFloat) {
		UIView.animate(
			withDuration: Constants.animationDuration,
			delay: Constants.delay,
			usingSpringWithDamping: Constants.springDamping,
			initialSpringVelocity: Constants.springVelocity,
			options: Constants.animationOptions
		) {
			self.transform = CGAffineTransform(scaleX: scale, y: scale)
		}
	}
	
	func animateEnlarge() {
		animateScale(to: Constants.enlargeScale)
	}
	
	func animateReduce() {
		animateScale(to: Constants.reduceScale)
	}
}

extension TrackImageView {
	enum NextPrevious {
		case next
		case previous
		
		var animation: String {
			switch self {
			case .next:
				AnimationPreset.squeezeLeft.rawValue
			case .previous:
				AnimationPreset.squeezeRight.rawValue
			}
		}
	}
}

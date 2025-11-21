
import UIKit
import Kingfisher

extension TrackImageView {
	func setImage(urlString: String?) {
		guard let urlString, let url = URL(string: urlString) else {
			self.image = UIImage(systemName: "photo")
			return
		}
		
		let processor = ResizingImageProcessor(referenceSize: Constants.targetImageSize)

		kf.indicatorType = .activity
		kf.setImage(
			with: url,
			options: [
				.processor(processor),
				.scaleFactor(UIScreen.main.scale),
				.transition(.fade(Constants.fadeDuration)),
				.cacheOriginalImage
			]
		)
	}
}

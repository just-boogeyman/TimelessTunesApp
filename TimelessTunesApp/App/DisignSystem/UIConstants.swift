
import UIKit

enum UIConstants {
	enum Layout {
		static let mainInset: CGFloat = 30
		static let mainStackSpacing: CGFloat = 16
		static let sliderStackSpacing: CGFloat = 4
		static let buttonStackSpacing: CGFloat = 20
		static let volumeStackSpacing: CGFloat = 10
		static let closeButtonHeight: CGFloat = 44
		static let minMaxIconSize: CGFloat = 20
		static let timeSliderHeight: CGFloat = 28
		static let volumeSliderHeight: CGFloat = 20
	}

	enum Font {
		static let timeLabel: CGFloat = 12
		static let title: CGFloat = 24
	}

	enum Colors {
		static let accent = UIColor(red: 232/255, green: 69/255, blue: 90/255, alpha: 1)
	}

	enum Default {
		static let volume: Float = 0.5
		static let timeStart = "00:00"
		static let timeUnknown = "--:--"
	}
}

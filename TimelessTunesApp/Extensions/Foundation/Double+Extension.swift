
import Foundation

extension Double {
	func toTime() -> String {
		guard self.isFinite && self >= 0 else { return "--:--" }
		let mins = Int(self) / 60
		let secs = Int(self) % 60
		return String(format: "%02d:%02d", mins, secs)
	}
}

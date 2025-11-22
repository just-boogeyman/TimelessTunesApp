
import UIKit

extension HomeCollectionViewCell {
	enum Constants {
		enum Layout {
			static let cornerRadius: CGFloat = 15
			static let shadowOpacity: Float = 0.1
			static let shadowOffset = CGSize(width: 3, height: 3)
			static let shadowRadius: CGFloat = 3
			
			static let contentInset: CGFloat = 8
			static let imageHeight: CGFloat = 125
			static let stackSpacing: CGFloat = 4
			
			static let minNumberOfLines: Int = 0
			static let maxNumberOfLines: Int = 0
		}
		
		enum Font {
			static let trackName = UIFont.systemFont(ofSize: 14, weight: .semibold)
			static let artistName = UIFont.systemFont(ofSize: 12, weight: .regular)
		}
		
		enum Color {
			static let background = UIColor.white
			static let textPrimary = UIColor(resource: .textPrimary)
			static let shadow = UIColor.black.cgColor
		}
	}
}


import UIKit
@testable import TimelessTunesApp

final class HomeViewMock: UIView, IHomeContentView
{	
	var viewModel: HomeViewModel?
	var touchHandler: ((Int) -> Void)?
	
	func displayData(viewModel: HomeViewModel) {
		self.viewModel = viewModel
	}
}

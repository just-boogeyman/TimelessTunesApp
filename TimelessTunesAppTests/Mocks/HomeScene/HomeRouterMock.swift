
import Foundation
@testable import TimelessTunesApp

final class HomeRouterMock: IHomeRouter
{
	var receivedItems: [MediaItem] = []
	var receivedIndex: Int?
	
	func next(items: [MediaItem], index: Int) {
		self.receivedItems = items
		self.receivedIndex = index
	}
}

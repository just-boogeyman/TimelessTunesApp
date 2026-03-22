
import Foundation
@testable import TimelessTunesApp

final class HomeInteractorInputMock: IHomeInteractorInput
{
	var searchText: String?
	var didCallLoadHistory = false
	var savedTrack: MediaItem?
	
	func searchTracks(searchText: String) {
		self.searchText = searchText
	}
	
	func saveTrackToHistory(_ track: MediaItem) {
		self.savedTrack = track
	}
	
	func loadHistoryTracks() {
		didCallLoadHistory = true
	}
}

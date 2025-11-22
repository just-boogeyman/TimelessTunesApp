
import Foundation

struct HomeViewModel {
	struct Cell: ITrackCellViewModel {
		var iconUrlString: String?
		var trackName: String
		var artistName: String
		let previewUrl: String?
	}
	
	let cells: [Cell]
}

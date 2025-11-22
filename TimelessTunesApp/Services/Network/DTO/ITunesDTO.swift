
import Foundation


struct ITunesSearchResponse: Decodable {
	let resultCount: Int
	let results: [ITunesItemDTO]
}

struct ITunesItemDTO: Decodable {
	let trackId: Int?
	let artistName: String?
	let collectionName: String?
	let trackName: String?
	let artworkUrl100: String?
	let previewUrl: String?
}

extension ITunesItemDTO {
	private enum Default {
		static let id = 0
		static let artistName = "Unknown Artist"
		static let trackName = "Unknown Track"
		static let artworkUrl = ""
		static let previewUrl = ""
	}
	
	func toEntity() -> MediaItem {
		MediaItem(
			 id: trackId ?? Default.id,
			 artistName: artistName ?? Default.artistName,
			 trackName: trackName ?? Default.trackName,
			 artworkUrl: artworkUrl100 ?? Default.artworkUrl,
			 previewUrl: previewUrl ?? Default.previewUrl
		 )
	}
}

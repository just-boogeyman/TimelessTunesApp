//
//  ITunesDTO.swift
//  TimelessTunesApp
//
//  Created by Ярослав Кочкин on 15.11.2025.
//

import Foundation


struct ITunesSearchResponse: Decodable {
	let resultCount: Int
	let results: [ITunesItemDTO]
}

struct ITunesItemDTO: Decodable {
	let trackId: Int?
	let artistName: String?
	let trackName: String?
	let artworkUrl100: String?
}

extension ITunesItemDTO {
	func toEntity() -> MediaItem {
		MediaItem(
			id: trackId ?? 0,
			artistName: artistName ?? "Unknown",
			trackName: trackName ?? "No Title",
			artworkUrl: artworkUrl100
		)
	}
}
